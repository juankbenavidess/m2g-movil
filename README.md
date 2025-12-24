# Meet2Go

App móvil para comprar tickets de eventos en tiempo real.

## Ejecutar el proyecto

```bash
flutter pub get
flutter run
```

Asegúrate de tener un emulador Android/iOS corriendo o un dispositivo físico conectado.

Si modificas archivos con anotaciones de Freezed o Riverpod:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Stack

- Flutter 3.x
- Dart 3.7+
- Riverpod para state management
- GoRouter para navegación
- Dio para llamadas HTTP
- Flutter Secure Storage para tokens
- Freezed para modelos inmutables
- Code generation (build_runner, json_serializable)

## Estructura

```
lib/
├── core/
│   ├── config/        # API config, router
│   ├── network/       # Dio client
│   ├── storage/       # Secure storage service
│   ├── theme/         # Tema de la app
│   └── widgets/       # Widgets compartidos
└── features/
    ├── auth/          # Login y registro
    ├── events/        # Lista de eventos
    └── tickets/       # Compra y mis tickets
```

Cada feature sigue Clean Architecture:
- `data/models/` - Modelos con Freezed
- `data/repositories/` - Lógica de datos
- `presentation/providers/` - Estado con Riverpod
- `presentation/pages/` - Pantallas

## Features

- Login y registro con email/password
- Lista de eventos disponibles
- Compra de tickets para eventos
- Ver mis tickets comprados
- Persistencia de sesión con tokens

## Probar

Usuario de prueba (crear con backend):
- Email: test@example.com
- Password: password123

Backend esperado: `http://localhost:3000` (debe estar corriendo)

Endpoints usados:
- POST `/auth/register` - Registro
- POST `/auth/login` - Login
- GET `/events` - Listar eventos
- POST `/tickets/purchase` - Comprar ticket
- GET `/tickets/my-tickets` - Mis tickets