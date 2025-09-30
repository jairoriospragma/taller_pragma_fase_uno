# Arquitectura

Este proyecto sigue el patrón **Clean Architecture**, separando la lógica de negocio, la gestión de datos y la presentación en capas independientes:

- **Domain**: Contiene las entidades principales (`Contact`), los casos de uso (`GetContactsUseCase`, `AddContactUseCase`, `DeleteContactUseCase`) y los contratos de los repositorios (`ContactsRepository`).
- **Data**: Implementa los repositorios, en este caso usando `SharedPreferences` para persistencia local (`SharedPrefsContactsRepository`).
- **Presentation**: Incluye la interfaz de usuario y la gestión de estado (Riverpod), con pantallas para listar contactos (`HomeScreen`), crear nuevos (`FormScreen`), ver detalles (`DetailScreen`) y eliminar contactos.

## Funcionalidad
La aplicación permite la **gestión de contactos**:
- Crear nuevos contactos.
- Ver la lista de contactos creados.
- Consultar los detalles de cada contacto.
- Eliminar contactos.

Cada contacto tiene nombre, teléfono y avatar. La persistencia se realiza localmente usando `SharedPreferences`.

### Flujo principal
1. **HomeScreen**: Muestra la lista de contactos y permite navegar al formulario de creación.
2. **FormScreen**: Permite ingresar los datos de un nuevo contacto y guardarlo.
3. **DetailScreen**: Muestra la información detallada de un contacto seleccionado.
4. **Gestión**: Los casos de uso y el repositorio gestionan la lógica de negocio y la persistencia.

La arquitectura facilita la escalabilidad y el mantenimiento, permitiendo cambiar la fuente de datos o la lógica de negocio sin afectar la interfaz de usuario.

# Taller Pragma Fase Uno

Este proyecto es una aplicación Flutter desarrollada como parte del taller de Pragma, fase uno. Incluye soporte para Android, iOS y Web.

## Estructura del proyecto
- **lib/**: Código fuente principal de la aplicación.
    - **data/**: Repositorios y acceso a datos.
    - **domain/**: Entidades, casos de uso y lógica de negocio.
    - **presentation/**: Páginas, widgets, proveedores y rutas de la interfaz de usuario.
    - **utils/**: Utilidades y constantes.
- **test/**: Pruebas unitarias y de widgets.
- **android/**, **ios/**, **web/**: Archivos y configuración para cada plataforma.

## Requisitos
- Flutter SDK
- Dart

## Instalación
1. Clona el repositorio:
   ```bash
   git clone https://github.com/jairoriospragma/taller_pragma_fase_uno.git
   ```
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

## Ejecución
Para correr la aplicación en modo desarrollo:
```bash
flutter run
```

Para ejecutar pruebas:
```bash
flutter test
```

## Estructura recomendada de carpetas
- `lib/`: Código fuente principal
- `test/`: Pruebas
- `android/`, `ios/`, `web/`: Plataformas soportadas

## Autor
- Jairo Ríos

## Licencia
Este proyecto está bajo la licencia MIT.
