# SearchChallenge

Aplicación nativa iOS desarrollada en **SwiftUI**, que permite buscar productos en el catálogo de Walmart usando la API pública de RapidAPI. Implementa arquitectura limpia, principios SOLID y patrones de diseño modernos para un desarrollo escalable y mantenible.

---

## Arquitectura

El proyecto sigue **Clean Architecture**, separando responsabilidades en capas:

- **Presentation**: Vista y ViewModel, gestión de estado y lógica de presentación.
- **Domain**: Entidades de negocio y abstracciones (protocolos de repositorio).
- **Data**: Implementación de repositorios, servicios de red, mapeo de modelos, almacenamiento local.

Esto asegura un bajo acoplamiento y alta cohesión entre módulos.

---

## Patrones de Diseño Utilizados

- **MVVM-E (Model-View-ViewModel with Environment):**
  - Las vistas observan el estado del ViewModel mediante `@ObservedObject`.
  - El ViewModel comunica cambios y maneja la lógica de negocio.
  - Las dependencias (repositorios) se inyectan, facilitando el testing.

- **Coordinator (SwiftUI Adaptado):**
  - Controla la navegación y el flujo principal de la app.
  - Permite separar la navegación de la lógica de presentación, mejorando la escalabilidad.

- **Repository Pattern:**
  - Los datos se obtienen a través de protocolos abstractos (`ProductRepository`, `SearchHistoryRepository`).
  - Las implementaciones (`ProductRepositoryImpl`, `SearchHistoryRepositoryImpl`) pueden cambiar sin afectar la capa de presentación.

---

## Principios SOLID Aplicados

- **S (Single Responsibility):**
  - Cada clase/struct cumple una sola función (ej: el ViewModel solo coordina la vista y los datos).
- **O (Open/Closed):**
  - Las abstracciones permiten extender la funcionalidad (por ejemplo, cambiar la fuente de datos sin modificar las vistas).
- **L (Liskov Substitution):**
  - Los repositorios pueden ser reemplazados por mocks o implementaciones alternativas sin alterar el contrato.
- **I (Interface Segregation):**
  - Se definen protocolos con las funciones mínimas necesarias, evitando dependencias innecesarias.
- **D (Dependency Inversion):**
  - La presentación depende de abstracciones (protocolos), no de implementaciones concretas.

---

## Buenas Prácticas Adicionales

- **UI programática 100% SwiftUI.**
- **Gestión del estado y la navegación desacoplada.**
- **Reutilización de componentes visuales y de lógica.**
- **Constantes centralizadas en archivos separados (colores, strings, endpoints).**
- **Persistencia local de búsquedas usando UserDefaults y repositorio.**
- **Carga asincrónica de imágenes y spinner de progreso (ProgressView) para mejor UX.**

---

## Ejecución

1. Clonar el repositorio y abrir el proyecto en Xcode 15 o superior.
2. Ejecutar en un simulador iOS 17 o superior.
3. Ingresar una palabra clave en inglés para buscar productos (ej: `nintendo`, `sony`, etc).
4. El historial de búsquedas se mantiene localmente y se puede limpiar desde la interfaz.

---
