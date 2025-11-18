import 'package:flutter/material.dart';

// 1. Punto de entrada
void main() {
  runApp(const MiAppFinanzas());
}

// 2. Configuración Global
class MiAppFinanzas extends StatelessWidget {
  const MiAppFinanzas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Gastos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const PantallaPrincipal(),
    );
  }
}

// 3. Pantalla Principal (Stateful)
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  // Lista de movimientos
  final List<Transaccion> _movimientos = [
    Transaccion(
      id: '1',
      titulo: 'Supermercado',
      monto:
          150.0, // Guardamos positivo, usamos el bool esGasto para saber qué es
      esGasto: true,
      fecha: DateTime.now(),
    ),
    Transaccion(
      id: '2',
      titulo: 'Nómina',
      monto: 2500.0,
      esGasto: false,
      fecha: DateTime.now(),
    ),
  ];

  // --- CORREGIDO: LÓGICA DE CÁLCULO ---
  // Estos "getters" calculan los totales en tiempo real basándose en la lista
  double get _totalIngresos {
    return _movimientos
        .where((t) => !t.esGasto)
        .fold(0.0, (suma, t) => suma + t.monto);
  }

  double get _totalGastos {
    return _movimientos
        .where((t) => t.esGasto)
        .fold(0.0, (suma, t) => suma + t.monto);
  }

  double get _balanceTotal => _totalIngresos - _totalGastos;
  // ------------------------------------

  // Controladores
  final _tituloController = TextEditingController();
  final _montoController = TextEditingController();
  bool _esGasto = true;

  // Iconos dinámicos (¡Muy buena función esta!)
  IconData _iconFor(Transaccion t) {
    final lower = t.titulo.toLowerCase();
    if (lower.contains('super') || lower.contains('mercado'))
      return Icons.shopping_cart;
    if (lower.contains('nómina') || lower.contains('sueldo')) return Icons.work;
    if (lower.contains('netflix') || lower.contains('cine')) return Icons.movie;
    if (lower.contains('gimnasio')) return Icons.fitness_center;
    return Icons.attach_money;
  }

  void _agregarMovimiento(String titulo, double monto, bool esGasto) {
    final nuevaTx = Transaccion(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      titulo: titulo,
      monto: monto,
      esGasto: esGasto,
      fecha: DateTime.now(),
    );

    setState(() {
      _movimientos.insert(0, nuevaTx);
    });
  }

  void _eliminarMovimiento(String id) {
    setState(() {
      _movimientos.removeWhere((tx) => tx.id == id);
    });
  }

  void _mostrarFormulario(BuildContext ctx) {
    _tituloController.clear();
    _montoController.clear();
    // Resetear el switch a "Gasto" por defecto al abrir
    setState(() {
      _esGasto = true;
    });

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        // Usamos StatefulBuilder AQUÍ para que el Switch del modal funcione visualmente
        // (Un truco avanzado: el modal es una pantalla aparte y necesita su propio estado)
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _tituloController,
                    decoration: const InputDecoration(labelText: 'Concepto'),
                    // Autocapitalización para que se vea bonito
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _montoController,
                    decoration: const InputDecoration(labelText: 'Monto'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _esGasto ? 'Es un Gasto' : 'Es un Ingreso',
                        style: TextStyle(
                          color: _esGasto ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        value: _esGasto,
                        activeColor: Colors.red,
                        inactiveThumbColor: Colors.green,
                        inactiveTrackColor: Colors.green.shade100,
                        onChanged: (val) {
                          // Usamos setModalState para actualizar SOLO el modal
                          setModalState(() => _esGasto = val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      final texto = _tituloController.text.trim();
                      // Reemplazamos coma por punto para decimales (España/Latam)
                      final dinero = double.tryParse(
                        _montoController.text.replaceAll(',', '.'),
                      );

                      if (texto.isEmpty || dinero == null || dinero <= 0) {
                        return;
                      }

                      // Enviamos siempre el valor positivo, el bool _esGasto define qué es
                      _agregarMovimiento(texto, dinero, _esGasto);
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Guardar'),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _montoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mis Finanzas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- CORREGIDO: PASAR DATOS REALES ---
          // Ahora le pasamos las variables calculadas, no dejaremos que use las suyas por defecto
          TarjetaBalance(
            balance: _balanceTotal,
            ingresos: _totalIngresos,
            gastos: _totalGastos,
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Movimientos Recientes",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Contador de items
                Text(
                  "${_movimientos.length}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: _movimientos.isEmpty
                ? const Center(child: Text("¡Añade tu primer gasto!"))
                : ListView.builder(
                    // Usamos builder es más eficiente para listas largas
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _movimientos.length,
                    itemBuilder: (ctx, i) {
                      final t = _movimientos[i];
                      return Dismissible(
                        // Deslizar para borrar
                        key: Key(t.id),
                        background: Container(color: Colors.red),
                        onDismissed: (_) => _eliminarMovimiento(t.id),
                        child: ItemTransaccion(
                          titulo: t.titulo,
                          monto: t.monto,
                          icono: _iconFor(t),
                          esGasto: t.esGasto,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormulario(context),
        label: const Text("Agregar"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

// --- WIDGETS MODIFICADOS PARA RECIBIR DATOS ---

class TarjetaBalance extends StatelessWidget {
  // Agregamos variables para recibir los datos
  final double balance;
  final double ingresos;
  final double gastos;

  const TarjetaBalance({
    super.key,
    // Requerimos los datos obligatoriamente
    required this.balance,
    required this.ingresos,
    required this.gastos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text("Balance Total", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 10),
          // Usamos la variable 'balance' que nos pasaron
          Text(
            "\$ ${balance.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _InfoPequena(
                titulo: "Ingresos",
                valor: "+${ingresos.toStringAsFixed(2)}", // Variable real
                color: Colors.greenAccent,
              ),
              _InfoPequena(
                titulo: "Gastos",
                valor: "-${gastos.toStringAsFixed(2)}", // Variable real
                color: Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoPequena extends StatelessWidget {
  final String titulo;
  final String valor;
  final Color color;

  const _InfoPequena({
    required this.titulo,
    required this.valor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          titulo,
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),
        Text(
          valor,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class ItemTransaccion extends StatelessWidget {
  final String titulo;
  final double monto;
  final IconData icono;
  final bool esGasto;

  const ItemTransaccion({
    super.key,
    required this.titulo,
    required this.monto,
    required this.icono,
    required this.esGasto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icono, color: Colors.indigo),
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(esGasto ? "Gasto" : "Ingreso"),
        trailing: Text(
          // Mostramos signo + o - según corresponda
          "${esGasto ? '-' : '+'}\$${monto.abs().toStringAsFixed(2)}",
          style: TextStyle(
            color: esGasto ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// MODELO
class Transaccion {
  final String id;
  final String titulo;
  final double monto;
  final bool esGasto;
  final DateTime fecha;

  Transaccion({
    required this.id,
    required this.titulo,
    required this.monto,
    required this.esGasto,
    required this.fecha,
  });
}
