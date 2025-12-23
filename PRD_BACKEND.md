# Backend Meet2Go - Requisitos Técnicos

## ¿Qué voy a construir?

Un backend simple para demostrar Clean Architecture. Funcionalidades básicas:
- Autenticación (login + registro)
- Ver lista de eventos
- Comprar tickets

**No voy a hacer:** Crear/editar eventos, roles complejos, ni procesamiento de pagos real.

## Stack Técnico

- Node.js 20 + TypeScript 5.x
- Express.js
- JWT para autenticación
- bcrypt para passwords
- JSON files como base de datos (por ahora)

## Por qué estas decisiones

### JSON en vez de base de datos
Más rápido de implementar y demuestra igual de bien la arquitectura. Migrar a PostgreSQL después es solo cambiar los repositories, el resto del código queda igual.

### Incluí registro de usuarios aunque no lo pidieron
Login solo no sirve para probar la API. Necesito crear usuarios de prueba sin editar JSONs manualmente. Como Register usa el mismo código que Login (PasswordService + JWT), solo tomó 5 minutos agregarlo.

### Sin crear eventos
Los eventos vienen pre-cargados. El foco está en la arquitectura y el flujo de compra, no en hacer un CRUD completo. En la realidad, los organizadores ya habrían creado los eventos.

## Arquitectura

Clean Architecture con 3 capas principales:

```
src/
├── presentation/       # Controllers, Routes, Middlewares (capa HTTP)
├── application/        # Use Cases (lógica de negocio)
├── domain/            # Entidades + Interfaces
├── infrastructure/    # Implementaciones (repos, auth, JSON storage)
└── shared/            # Errores, utils, tipos
```

Cada capa solo conoce a la de abajo. Domain no sabe nada de Express ni de cómo se guardan los datos.

## Modelo de Datos

### User
```typescript
{
  id: string
  email: string
  password: string  // hasheado con bcrypt
  name: string
  createdAt: Date
}
```

### Event
```typescript
{
  id: string
  name: string
  description: string
  date: Date
  location: string
  price: number          // en centavos (2500 = $25.00)
  currency: string       // "USD"
  totalTickets: number
  availableTickets: number
  organizerName: string
  imageUrl?: string
}
```

### Ticket
```typescript
{
  id: string
  eventId: string
  userId: string
  quantity: number
  totalPrice: number
  status: 'confirmed'    // siempre confirmado (sin pago real)
  purchaseDate: Date
}
```

## API Endpoints

Base URL: `http://localhost:3000/api`

### 1. POST /api/auth/register
Crear usuario nuevo.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123",
  "name": "Juan Pérez"
}
```

**Response:** 201 + token JWT

### 2. POST /api/auth/login
Iniciar sesión.

**Request:**
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:** 200 + token JWT

### 3. GET /api/events
Listar todos los eventos. Requiere autenticación.

**Headers:** `Authorization: Bearer <token>`

### 4. POST /api/tickets/purchase
Comprar tickets. Requiere autenticación.

**Request:**
```json
{
  "eventId": "event-1",
  "quantity": 2
}
```

**Response:** 201 + ticket data con eventId

Validaciones:
- Cantidad entre 1 y 10
- Evento existe
- Hay tickets disponibles

### 5. GET /api/tickets/my-tickets
Ver mis compras. Requiere autenticación.

Incluye información del evento en cada ticket.

## Use Cases

Los 5 casos de uso principales:

1. **LoginUser** - Valida credenciales, genera JWT
2. **RegisterUser** - Hashea password, crea usuario, genera JWT
3. **GetAllEvents** - Devuelve todos los eventos del JSON
4. **PurchaseTicket** - Valida disponibilidad, crea ticket, decrementa stock
5. **GetUserTickets** - Busca tickets por userId, incluye info del evento

Cada Use Case está aislado y es fácil de testear.

## Middlewares

### authMiddleware
Verifica token JWT en header `Authorization: Bearer <token>`.
Si es válido, pone `req.userId` disponible para los controllers.

### errorHandler
Captura todos los errores y devuelve formato consistente:
```json
{
  "success": false,
  "error": {
    "message": "Descripción del error",
    "statusCode": 400
  }
}
```

## Estructura del Proyecto

```
m2g-backend/
├── src/
│   ├── application/
│   │   ├── LoginUser.ts
│   │   ├── RegisterUser.ts
│   │   ├── GetAllEvents.ts
│   │   ├── PurchaseTicket.ts
│   │   └── GetUserTickets.ts
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── User.ts
│   │   │   ├── Event.ts
│   │   │   └── Ticket.ts
│   │   └── repositories/
│   │       ├── IUserRepository.ts
│   │       ├── IEventRepository.ts
│   │       └── ITicketRepository.ts
│   ├── infrastructure/
│   │   ├── auth/
│   │   │   ├── JWTService.ts
│   │   │   └── PasswordService.ts
│   │   ├── data/
│   │   │   ├── users.json
│   │   │   ├── events.json
│   │   │   └── tickets.json
│   │   └── repositories/
│   │       ├── UserRepository.ts
│   │       ├── EventRepository.ts
│   │       └── TicketRepository.ts
│   ├── presentation/
│   │   ├── controllers/
│   │   ├── middlewares/
│   │   └── routes/
│   ├── shared/
│   │   ├── errors/
│   │   ├── types/
│   │   └── utils/
│   ├── app.ts
│   └── server.ts
├── Meet2Go.postman_collection.json
├── package.json
└── tsconfig.json
```

## Datos de Prueba

### Usuario pre-cargado
```
Email: user@example.com
Password: password123
```

### Eventos pre-cargados
- **event-1:** Campanazo Navideño: Pan de Dulce - $15.00 (300 tickets) - 25 dic, Guayaquil
- **event-2:** La Cotorrisa en Quito - $45.00 (800 tickets)
- **event-3:** Nicola Cruz con Silvia Ponce - $35.00 (500 tickets) - 26 dic

## Flujo de Compra

1. Usuario hace login → recibe JWT
2. Consulta eventos disponibles → GET /api/events
3. Compra tickets → POST /api/tickets/purchase
   - Se valida disponibilidad
   - Se crea el ticket
   - Se decrementa `availableTickets` del evento
4. Consulta sus tickets → GET /api/tickets/my-tickets

## Comandos

```bash
# Desarrollo (con hot-reload)
npm run dev

# Compilar
npm run build

# Producción
npm start

# Testing (cuando los agregue)
npm test

# Linting y formato
npm run lint
npm run format
```

## Manejo de Errores

Códigos de error:
- **400** - Validation Error (datos inválidos, cantidad excesiva, etc.)
- **401** - Unauthorized (token inválido/ausente)
- **404** - Not Found (evento no existe)
- **409** - Conflict (email ya existe)
- **500** - Internal Server Error

## Mejoras Futuras

Cosas que agregaría si esto fuera producción:

**Lo más importante:**
- Migrar a PostgreSQL (o al menos usar SQLite en vez de JSON)
- Tests unitarios básicos para los Use Cases
- Validación de inputs con Zod
- Procesamiento de pagos real con Stripe o PayPhone

**Si tuviera más tiempo:**
- Paginación y filtros en eventos
- Roles para que organizadores puedan crear eventos
- Subir imágenes de eventos a S3/Cloudinary
- Docker para despliegue fácil
- Rate limiting para evitar spam

## Por qué Clean Architecture aquí

Aunque es un proyecto pequeño, usar Clean Architecture:
1. Conocimiento del patron clean
2. Hace el código testeable (puedo mockear repositories fácilmente)
3. Facilita cambiar la implementación (JSON → PostgreSQL es trivial)
4. Separa preocupaciones claramente
5. Es escalable si el proyecto crece


---

**Versión:** 0.1.0
**Autor:** Juan Carlos Benavides
**Tiempo de desarrollo:** ~2 horas