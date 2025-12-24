# Flutter Meet2Go - Requisitos Técnicos

Construye app móvil simple para demostrar arquitectura limpia. Funcionalidades básicas:
- Login 
- Ver lista de eventos
- Detalle de evento + comprar tickets
- Confirmación de compra
- Ver mis tickets

**No voy a hacer:** Registro visible en UI, offline-first, ni funcionalidades complejas.

## Stack Técnico

- Flutter 3.16+
- Riverpod (state management)
- go_router (navegación)
- Dio (networking)
- flutter_securxwe_storage (tokens)
- Sin Freezed ni código generado excesivo

## Arquitectura

Clean Architecture con 3 capas principales:

```
lib/
├── core/              # Config, themes, networking
├── features/
│   ├── auth/         # Login
│   ├── events/       # Lista + detalle eventos
│   └── tickets/      # Comprar + mis tickets
└── main.dart
```

Cada feature tiene data, domain, presentation. Simple y directo.

## Modelo de Datos

### User
```dart
{
  "id": "user-1",
  "email": "user@example.com",
  "name": "Juan Pérez"
}
```

### Event
```dart
{
  "id": "event-1",
  "name": "Campanazo Navideño",
  "description": "Celebración navideña...",
  "date": "2024-12-25T19:00:00",
  "location": "Guayaquil",
  "price": 1500,  // en centavos
  "availableTickets": 300,
  "organizerName": "EventCorp"
}
```

### Ticket
```dart
{
  "id": "ticket-1",
  "eventId": "event-1",
  "quantity": 1,
  "totalPrice": 1500,
  "status": "confirmed",
  "purchaseDate": "2024-12-23T10:30:00"
}
```

## Pantallas

**IMPORTANTE:** Usar `inspiration_mockups.png` como referencia visual para crear las pantallas. Los mockups fueron generados con ChatGPT para guiar el diseño.

### 1. LOGIN
Pantalla simple con email, password y botón "Iniciar sesión". Logo naranja arriba.

### 2. LISTA DE EVENTOS
Tarjetas verticales con imagen, nombre, fecha, ubicación. AppBar negro con logo naranja.

### 3. DETALLE DE EVENTO
Imagen de fondo, overlay blanco con info del evento, mapa placeholder, botón "Comprar ticket".

### 4. TICKET COMPRADO
Confirmación con QR code, info del evento, badge "VÁLIDO", botones de descarga.

### 5. MIS TICKETS
Lista de tickets comprados con badge de estado, fecha, ubicación. Empty state si no hay tickets.

## API Endpoints

Base URL: `http://localhost:3000/api`

### Auth
- POST `/api/auth/login` - Iniciar sesión

### Eventos
- GET `/api/events` - Listar todos los eventos (requiere auth)

### Tickets
- POST `/api/tickets/purchase` - Comprar tickets (requiere auth)
- GET `/api/tickets/my-tickets` - Ver mis compras (requiere auth)

## Flujo de Compra

1. Login → recibe JWT
2. Ver eventos → GET /api/events
3. Comprar tickets → POST /api/tickets/purchase
4. Ver mis tickets → GET /api/tickets/my-tickets

## Comandos

```bash
# Instalar dependencias
flutter pub get

# Generar código
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar
flutter run
```

## Datos de Prueba

```
Email: user@example.com
Password: password123
```

## Flujo de Desarrollo por Fases

### Fase 1: Setup inicial (15 min)
- Crear proyecto Flutter
- Instalar dependencias (Riverpod, go_router, Dio)
- Configurar estructura de carpetas
- Setup básico de theme y routing

### Fase 2: Core y Auth (20 min)
- Dio client para networking
- Secure storage para tokens
- Auth feature completo (login)
- Navegación básica

### Fase 3: Events feature (25 min)
- Modelos y repositories de eventos
- Pantalla lista de eventos
- Pantalla detalle de evento
- Integración con API

### Fase 4: Tickets feature (30 min)
- Modelos y repositories de tickets
- Flujo de compra
- Pantalla confirmación de compra
- Pantalla "Mis Tickets"

### Fase 5: Testing y ajustes (10 min)
- Probar flujo completo
- Ajustes de UI
- Manejo de errores

---

**Autor:** Juan Carlos Benavides