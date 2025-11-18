import 'package:flutter/material.dart';

// 1. Punto de entrada de la App
void main() {
  runApp(const MiAppFinanzas());
}

// 2. Configuración Global de la App (Colores, Títulos)
class MiAppFinanzas extends StatelessWidget {
  const MiAppFinanzas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Gastos',
      debugShowCheckedModeBanner: false, // Quita la etiqueta "Debug"
      theme: ThemeData(
        // Usamos Material 3, el diseño moderno de Google
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const PantallaPrincipal(),
    );
  }
}

// 3. La Pantalla Principal
class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar: La barra superior
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mi Billetera'),
        centerTitle: true,
      ),

      // Body: El cuerpo de la app
      body: Column(
        children: [
          // --- SECCIÓN 1: Tarjeta de Balance ---
          const TarjetaBalance(),

          // --- SECCIÓN 2: Título de la lista ---
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
                const Icon(Icons.history, color: Colors.grey),
              ],
            ),
          ),

          // --- SECCIÓN 3: Lista de Gastos (Datos falsos por ahora) ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                ItemTransaccion(
                  titulo: "Supermercado",
                  monto: -150.00,
                  icono: Icons.shopping_cart,
                  esGasto: true,
                ),
                ItemTransaccion(
                  titulo: "Nómina",
                  monto: 2500.00,
                  icono: Icons.work,
                  esGasto: false,
                ),
                ItemTransaccion(
                  titulo: "Netflix",
                  monto: -12.99,
                  icono: Icons.movie,
                  esGasto: true,
                ),
                ItemTransaccion(
                  titulo: "Gimnasio",
                  monto: -45.00,
                  icono: Icons.fitness_center,
                  esGasto: true,
                ),
              ],
            ),
          ),
        ],
      ),

      // FloatingActionButton: El botón flotante para agregar
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Aquí programaremos la lógica en la Etapa 2
          print("Click en agregar");
        },
        label: const Text("Agregar"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

// --- Widgets Personalizados (Tus propios bloques de LEGO) ---

class TarjetaBalance extends StatelessWidget {
  const TarjetaBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo, // Color de fondo
        borderRadius: BorderRadius.circular(20), // Bordes redondeados
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
          const Text(
            "\$ 2,292.01",
            style: TextStyle(
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
                valor: "+2,500",
                color: Colors.greenAccent,
              ),
              _InfoPequena(
                titulo: "Gastos",
                valor: "-207.99",
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
      elevation: 0, // Sin sombra
      color: Colors.grey.shade100, // Fondo gris claro
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
          "${esGasto ? '-' : '+'}\$${monto.abs()}",
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
