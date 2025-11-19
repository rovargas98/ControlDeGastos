# ControlDeGastos
# 💰 Control de Gastos (Mi Billetera)

> Sistema de gestión de finanzas personales desarrollado en Flutter con enfoque Offline-First y diseño Material 3.

![Estado del Proyecto](https://img.shields.io/badge/Estado-Fase%202%3A%20Lógica%20Local-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)

## 📋 Descripción del Proyecto

**Control de Gastos** es una aplicación móvil multiplataforma diseñada para resolver la dificultad de llevar un registro inmediato de las finanzas personales. El objetivo principal es ofrecer al usuario una visualización clara de su salud financiera (déficit vs. superávit) en tiempo real mediante una interfaz limpia y eficiente.

Actualmente, la aplicación permite el registro rápido de transacciones, cálculo automático de balances y categorización visual inteligente.

## ✨ Características Principales

* **Balance en Tiempo Real:** Cálculo automático de ingresos, gastos y balance total utilizando getters dinámicos y programación reactiva.
* **Gestión de Transacciones:**
    * Agregar ingresos y gastos mediante un formulario modal (`ModalBottomSheet`).
    * Eliminar movimientos con gestos de deslizamiento (`Dismissible`).
* **UX Inteligente:** Asignación automática de iconos basada en palabras clave del concepto (ej. "Netflix" → 🎬, "Supermercado" → 🛒).
* **Diseño Moderno:** Interfaz construida con **Material Design 3**, utilizando una paleta de colores generada por semilla (`Colors.indigo`).

## 🛠️ Stack Tecnológico

* **Framework:** Flutter (Dart).
* **Arquitectura UI:** Modularización con Widgets personalizados (`TarjetaBalance`, `ItemTransaccion`) para mantener el principio de *Clean Code*.
* **Gestión de Estado:** `StatefulWidget` para el manejo de listas dinámicas y renderizado reactivo (`setState`).
* **Modelo de Datos:** Clase `Transaccion` fuertemente tipada.

## 📂 Estructura del Proyecto

El código sigue una estructura clara para facilitar la escalabilidad:

lib/
├── main.dart # Punto de entrada y configuración del tema (MaterialApp)
├── models/
│ └── transaccion.dart # Definición de la clase de datos
├── widgets/
│ ├── tarjeta_balance.dart # Componente visual de resumen financiero
│ └── item_transaccion.dart # Componente visual para cada fila de la lista
└── screens/
└── pantalla_principal.dart # Lógica principal, estado y estructura visual

## 🚀 Instalación y Ejecución

1.  **Clonar el repositorio:**
    ```
    git clone https://github.com/tu-usuario/control-de-gastos.git
    ```
2.  **Instalar dependencias:**
    ```
    flutter pub get
    ```
3.  **Ejecutar la aplicación:**
    ```
    flutter run
    ```
    *Para probar en navegador (Fase 1/2):* `flutter run -d web-server`

## 🗺️ Roadmap (Hoja de Ruta)

El desarrollo sigue un plan escalonado para asegurar calidad y funcionalidad:

- [x] **Fase 1: UI Estática:** Diseño de pantallas y widgets base.
- [x] **Fase 2: Lógica Local:** Interactividad, formularios y gestión de estado en memoria.
- [ ] **Fase 3: Persistencia (En Progreso):** Integración con **Firebase Firestore** para respaldo de datos en la nube.
- [ ] **Fase 4: Seguridad:** Autenticación de usuarios y adaptación responsiva.
