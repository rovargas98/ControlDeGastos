# ControlDeGastos
# 💰 Control de Gastos (Mi Billetera)

> Sistema de gestión de finanzas personales desarrollado en Flutter con enfoque Offline-First y diseño Material 3.

![Estado del Proyecto](https://img.shields.io/badge/Estado-Fase%202%3A%20Lógica%20Local-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)

## 📋 Descripción del Proyecto

[cite_start]**Control de Gastos** es una aplicación móvil multiplataforma diseñada para resolver la dificultad de llevar un registro inmediato de las finanzas personales[cite: 73]. [cite_start]El objetivo principal es ofrecer al usuario una visualización clara de su salud financiera (déficit vs. superávit) en tiempo real mediante una interfaz limpia y eficiente[cite: 73, 74].

[cite_start]Actualmente, la aplicación permite el registro rápido de transacciones, cálculo automático de balances y categorización visual inteligente[cite: 7, 10].

## ✨ Características Principales

* [cite_start]**Balance en Tiempo Real:** Cálculo automático de ingresos, gastos y balance total utilizando getters dinámicos y programación reactiva[cite: 7, 8, 9].
* **Gestión de Transacciones:**
    * [cite_start]Agregar ingresos y gastos mediante un formulario modal (`ModalBottomSheet`)[cite: 18, 33].
    * [cite_start]Eliminar movimientos con gestos de deslizamiento (`Dismissible`)[cite: 44, 45].
* [cite_start]**UX Inteligente:** Asignación automática de iconos basada en palabras clave del concepto (ej. "Netflix" → 🎬, "Supermercado" → 🛒)[cite: 10, 11, 12].
* [cite_start]**Diseño Moderno:** Interfaz construida con **Material Design 3**, utilizando una paleta de colores generada por semilla (`Colors.indigo`)[cite: 3, 81].

## 🛠️ Stack Tecnológico

* [cite_start]**Framework:** Flutter (Dart)[cite: 76].
* [cite_start]**Arquitectura UI:** Modularización con Widgets personalizados (`TarjetaBalance`, `ItemTransaccion`) para mantener el principio de *Clean Code*[cite: 85].
* [cite_start]**Gestión de Estado:** `StatefulWidget` para el manejo de listas dinámicas y renderizado reactivo (`setState`)[cite: 4, 14].
* [cite_start]**Modelo de Datos:** Clase `Transaccion` fuertemente tipada[cite: 66].

## 📂 Estructura del Proyecto

El código sigue una estructura clara para facilitar la escalabilidad:

lib/ ├── main.dart # Punto de entrada y configuración del tema (MaterialApp) ├── models/ │ └── transaccion.dart # Definición de la clase de datos ├── widgets/ │ ├── tarjeta_balance.dart # Componente visual de resumen financiero │ └── item_transaccion.dart # Componente visual para cada fila de la lista └── screens/ └── pantalla_principal.dart # Lógica principal, estado y estructura visual


## 🚀 Instalación y Ejecución

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/tu-usuario/control-de-gastos.git](https://github.com/tu-usuario/control-de-gastos.git)
    ```
2.  **Instalar dependencias:**
    ```bash
    flutter pub get
    ```
3.  **Ejecutar la aplicación:**
    ```bash
    flutter run
    ```
    [cite_start]*Para probar en navegador (Fase 1/2):* `flutter run -d web-server`[cite: 89].

## 🗺️ Roadmap (Hoja de Ruta)

El desarrollo sigue un plan escalonado para asegurar calidad y funcionalidad:

- [x] [cite_start]**Fase 1: UI Estática:** Diseño de pantallas y widgets base[cite: 90, 91].
- [x] [cite_start]**Fase 2: Lógica Local:** Interactividad, formularios y gestión de estado en memoria[cite: 93, 94].
- [ ] [cite_start]**Fase 3: Persistencia (En Progreso):** Integración con **Firebase Firestore** para respaldo de datos en la nube[cite: 96].
- [ ] [cite_start]**Fase 4: Seguridad:** Autenticación de usuarios y adaptación responsiva[cite: 99, 100].
