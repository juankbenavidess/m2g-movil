# PRD - Flutter SIMPLIFICADO Meet2Go
## Product Requirements Document - Prueba Técnica (2 horas)

---

## 1. VISIÓN GENERAL

### 1.1 Propósito
App móvil minimalista para demostrar Clean Architecture + Riverpod con **5 pantallas**:
1. **Login** (Autenticación)
2. **Lista de Eventos** (Ver todos los eventos)
3. **Detalle del Evento** (Info + Comprar)
4. **Ticket Comprado** (Confirmación con QR - después de comprar)
5. **Mis Tickets** (Lista de todos mis tickets comprados)

### 1.2 Alcance - MÍNIMO VIABLE
- ✅ Login (sin register en UI)
- ✅ Lista de eventos con imágenes
- ✅ Detalle de evento con mapa y botón comprar
- ✅ Pantalla de confirmación con QR (después de comprar)
- ✅ Pantalla de "Mis Tickets" (lista de tickets comprados)
- ✅ Riverpod Generator + Freezed
- ❌ NO registro visible (backend lo tiene, pero no UI)
- ❌ NO offline-first (solo online)

### 1.3 Stack Tecnológico
- **Framework:** Flutter 3.16+
- **State Management:** Riverpod Generator 2.5+
- **Code Generation:** Freezed 2.4+
- **Routing:** go_router 13+
- **Network:** Dio 5.4+
- **Storage:** flutter_secure_storage 9.0+

---

## 2. ARQUITECTURA ULTRA-SIMPLIFICADA

### 2.1 Estructura Feature-First Mínima

```
lib/
├── core/
│   ├── config/
│   │   ├── api_config.dart
│   │   └── app_router.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── network/
│   │   └── dio_client.dart
│   └── storage/
│       └── secure_storage_service.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   ├── user_model.freezed.dart
│   │   │   │   └── user_model.g.dart
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       └── login_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── auth_provider.dart
│   │       │   └── auth_provider.g.dart
│   │       ├── pages/
│   │       │   └── login_page.dart
│   │       └── widgets/
│   │           └── login_form.dart
│   │
│   ├── events/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── event_model.dart
│   │   │   │   ├── event_model.freezed.dart
│   │   │   │   └── event_model.g.dart
│   │   │   ├── datasources/
│   │   │   │   └── events_remote_datasource.dart
│   │   │   └── repositories/
│   │   │       └── events_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── event.dart
│   │   │   ├── repositories/
│   │   │   │   └── events_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_events_usecase.dart
│   │   │       └── get_event_by_id_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── events_provider.dart
│   │       │   ├── events_provider.g.dart
│   │       │   ├── event_detail_provider.dart
│   │       │   └── event_detail_provider.g.dart
│   │       ├── pages/
│   │       │   ├── events_list_page.dart
│   │       │   └── event_detail_page.dart
│   │       └── widgets/
│   │           ├── event_card.dart
│   │           └── event_image_header.dart
│   │
│   └── tickets/
│       ├── data/
│       │   ├── models/
│       │   │   ├── ticket_model.dart
│       │   │   ├── ticket_model.freezed.dart
│       │   │   └── ticket_model.g.dart
│       │   ├── datasources/
│       │   │   └── tickets_remote_datasource.dart
│       │   └── repositories/
│       │       └── tickets_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── ticket.dart
│       │   ├── repositories/
│       │   │   └── tickets_repository.dart
│       │   └── usecases/
│       │       └── purchase_ticket_usecase.dart
│       └── presentation/
│           ├── providers/
│           │   ├── purchase_provider.dart
│           │   └── purchase_provider.g.dart
│           ├── pages/
│           │   └── ticket_purchased_page.dart
│           └── widgets/
│               └── ticket_qr_widget.dart
│
├── main.dart
└── app.dart
```

**TOTAL: ~40 archivos** (manejable en 2h con code generation)

---

## 3. MODELO DE DATOS (con Freezed)

### 3.1 User Entity + Model

```dart
// domain/entities/user.dart
class User {
  final String id;
  final String email;
  final String name;

  const User({
    required this.id,
    required this.email,
    required this.name,
  });
}

// data/models/user_model.dart
@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String email,
    required String name,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() => User(id: id, email: email, name: name);
}
```

---

### 3.2 Event Entity + Model

```dart
// domain/entities/event.dart
class Event {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final String location;
  final int price;
  final String currency;
  final int availableTickets;
  final String organizerName;
  final String? imageUrl;

  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.price,
    required this.currency,
    required this.availableTickets,
    required this.organizerName,
    this.imageUrl,
  });

  String get formattedPrice => '\$${(price / 100).toStringAsFixed(2)}';
  String get formattedDate => '${date.day} de ${_monthName(date.month)} · ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  
  String _monthName(int month) {
    const months = ['', 'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
                    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'];
    return months[month];
  }
}

// data/models/event_model.dart
@freezed
class EventModel with _$EventModel {
  const EventModel._();

  const factory EventModel({
    required String id,
    required String name,
    required String description,
    required DateTime date,
    required String location,
    required int price,
    required String currency,
    @JsonKey(name: 'availableTickets') required int availableTickets,
    @JsonKey(name: 'organizerName') required String organizerName,
    String? imageUrl,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Event toEntity() => Event(
    id: id,
    name: name,
    description: description,
    date: date,
    location: location,
    price: price,
    currency: currency,
    availableTickets: availableTickets,
    organizerName: organizerName,
    imageUrl: imageUrl,
  );
}
```

---

### 3.3 Ticket Entity + Model

```dart
// domain/entities/ticket.dart
class Ticket {
  final String id;
  final String eventId;
  final int quantity;
  final int totalPrice;
  final String status;
  final DateTime purchaseDate;
  
  // Event info (denormalized)
  final String eventName;
  final DateTime eventDate;
  final String eventLocation;

  const Ticket({
    required this.id,
    required this.eventId,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.purchaseDate,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
  });
}

// data/models/ticket_model.dart
@freezed
class TicketModel with _$TicketModel {
  const TicketModel._();

  const factory TicketModel({
    required String id,
    @JsonKey(name: 'eventId') required String eventId,
    required int quantity,
    @JsonKey(name: 'totalPrice') required int totalPrice,
    required String status,
    @JsonKey(name: 'purchaseDate') required DateTime purchaseDate,
    required EventInfoModel event,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Ticket toEntity() => Ticket(
    id: id,
    eventId: eventId,
    quantity: quantity,
    totalPrice: totalPrice,
    status: status,
    purchaseDate: purchaseDate,
    eventName: event.name,
    eventDate: event.date,
    eventLocation: event.location,
  );
}

@freezed
class EventInfoModel with _$EventInfoModel {
  const factory EventInfoModel({
    required String id,
    required String name,
    required DateTime date,
    required String location,
  }) = _EventInfoModel;

  factory EventInfoModel.fromJson(Map<String, dynamic> json) =>
      _$EventInfoModelFromJson(json);
}
```

---

## 4. PANTALLAS (Basadas en el diseño)

### 4.1 Pantalla 1: LOGIN

**Diseño:**
- Logo naranja arriba (icono de soundwave)
- Título "Login" centrado
- 2 campos: Email y Contraseña
- Botón naranja "Iniciar sesión"
- Link "Crear cuenta" (no funcional en v0.1)
- Link "¿Olvidaste tu contraseña?" (no funcional)
- Bottom navigation bar con 5 iconos

**Código simplificado:**

```dart
// features/auth/presentation/pages/login_page.dart

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Navigate on success
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is Authenticated) {
        context.go('/events');
      } else if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message), backgroundColor: Colors.red),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.graphic_eq, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 48),

              // Title
              const Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),

              // Email field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: authState is Loading
                      ? null
                      : () {
                          ref.read(authProvider.notifier).login(
                                _emailController.text,
                                _passwordController.text,
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: authState is Loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Iniciar sesión',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Create account (disabled)
              TextButton(
                onPressed: null,
                child: Text(
                  'Crear cuenta',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),

              // Forgot password (disabled)
              TextButton(
                onPressed: null,
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, 0),
    );
  }
}
```

---

### 4.2 Pantalla 2: LISTA DE EVENTOS

**Diseño:**
- AppBar negro con logo naranja y menú hamburguesa
- Lista vertical de tarjetas de eventos
- Cada tarjeta tiene:
  - Imagen de fondo (multitud en concierto)
  - Badge "NUEVO" naranja (opcional)
  - Nombre del evento
  - Fecha y hora
  - Ubicación (con icono)
  - Nombre del organizador (con icono)
- Bottom navigation bar activo en el icono central (naranja)

**Código simplificado:**

```dart
// features/events/presentation/pages/events_list_page.dart

class EventsListPage extends ConsumerWidget {
  const EventsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.graphic_eq, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: eventsAsync.when(
        data: (events) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(eventsProvider);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventCard(
                event: event,
                showNewBadge: index == 0, // Primer evento tiene badge
                onTap: () => context.go('/events/${event.id}'),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, 2),
    );
  }
}

// features/events/presentation/widgets/event_card.dart

class EventCard extends StatelessWidget {
  final Event event;
  final bool showNewBadge;
  final VoidCallback onTap;

  const EventCard({
    required this.event,
    this.showNewBadge = false,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  event.imageUrl ?? 'https://via.placeholder.com/400x200',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (showNewBadge)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'NUEVO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      event.formattedDate,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      event.location,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      event.organizerName,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

---

### 4.3 Pantalla 3: DETALLE DEL EVENTO

**Diseño:**
- Imagen de fondo full-width
- Overlay blanco redondeado desde abajo
- Título del evento
- Ubicación (con icono pin)
- Mapa estático (placeholder con pin naranja)
- Sección "Duda información" (placeholder)
- Avatar del artista con nombre "Kaley Smith"
- Géneros: "R&B · Trap · Nuevo soul · Hip-Hop"
- Botón naranja "Comprar ticket" al final

**Código simplificado:**

```dart
// features/events/presentation/pages/event_detail_page.dart

class EventDetailPage extends ConsumerWidget {
  final String eventId;

  const EventDetailPage({required this.eventId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));

    return Scaffold(
      body: eventAsync.when(
        data: (event) => Stack(
          children: [
            // Background image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 300,
              child: Image.network(
                event.imageUrl ?? 'https://via.placeholder.com/400x300',
                fit: BoxFit.cover,
              ),
            ),

            // White overlay with content
            DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(24),
                    children: [
                      // Title
                      Text(
                        event.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Location
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            event.location,
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Map placeholder
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Simulate map background
                            Opacity(
                              opacity: 0.3,
                              child: Image.network(
                                'https://via.placeholder.com/400x150',
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Pin
                            const Icon(
                              Icons.location_on,
                              color: Colors.orange,
                              size: 48,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Info section
                      const Text(
                        'Duda información',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 24),

                      // Artist info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.orange,
                            child: Text(
                              event.organizerName[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.organizerName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Organizador del evento',
                                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Buy button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            _showPurchaseDialog(context, ref, event);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Comprar ticket · ${event.formattedPrice}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Back button
            Positioned(
              top: 40,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _showPurchaseDialog(BuildContext context, WidgetRef ref, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comprar ticket'),
        content: const Text('¿Confirmar compra de 1 ticket?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(purchaseProvider.notifier).purchaseTicket(
                    eventId: event.id,
                    quantity: 1,
                  );
              
              // Navigate to success page
              final purchaseState = ref.read(purchaseProvider);
              if (purchaseState is PurchaseSuccess) {
                context.go('/ticket-purchased/${purchaseState.ticket.id}');
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
```

---

### 4.4 Pantalla 4: TICKET COMPRADO (Después de comprar)

**Diseño:**
- Header "Ticket comprado"
- Nombre del evento con badge "VÁLIDO" verde
- Fecha y hora
- Ubicación "Madison Square Garden"
- Información de asiento: Sector 102, Fila 12, Asiento 7
- QR Code grande en el centro
- Botón "Mostrar CR" (toggle)
- Botón "Descargar" con icono
- Bottom bar con botón "Descargar"

**Código simplificado:**

```dart
// features/tickets/presentation/pages/ticket_purchased_page.dart

class TicketPurchasedPage extends ConsumerWidget {
  final String ticketId;

  const TicketPurchasedPage({required this.ticketId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Simulando ticket data (en realidad vendría del provider)
    final purchaseState = ref.watch(purchaseProvider);
    
    if (purchaseState is! PurchaseSuccess) {
      return const Scaffold(
        body: Center(child: Text('Error cargando ticket')),
      );
    }

    final ticket = purchaseState.ticket;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Ticket comprado', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/my-tickets'),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Event name with badge
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      ticket.eventName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'VÁLIDO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Date
              Text(
                ticket.eventDate.toString(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),

              // Location
              Text(
                ticket.eventLocation,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Seat info (simulado)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SeatInfo(label: 'Sector', value: '102'),
                  _SeatInfo(label: 'Fila', value: '12'),
                  _SeatInfo(label: 'Asiento', value: '7'),
                ],
              ),
              const SizedBox(height: 32),

              // QR Code
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code, size: 120, color: Colors.grey[800]),
                      Text(
                        ticket.id.substring(0, 8),
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Mostrar CR'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text('Descargar'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download),
            label: const Text('Descargar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SeatInfo extends StatelessWidget {
  final String label;
  final String value;

  const _SeatInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
```

---

### 4.5 Pantalla 5: MIS TICKETS 🆕

**Diseño:**
- AppBar con título "Mis Tickets"
- Lista de tickets comprados
- Cada tarjeta muestra:
  - Imagen del evento
  - Nombre del evento
  - Badge de estado (VÁLIDO/USADO/EXPIRADO)
  - Fecha y hora
  - Ubicación
  - Botón "Ver QR"
- Pull to refresh
- Empty state si no hay tickets

**Código:**

```dart
// features/tickets/presentation/pages/my_tickets_page.dart

class MyTicketsPage extends ConsumerWidget {
  const MyTicketsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsAsync = ref.watch(myTicketsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Mis Tickets', style: TextStyle(color: Colors.white)),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.graphic_eq, color: Colors.white),
        ),
      ),
      body: ticketsAsync.when(
        data: (tickets) {
          if (tickets.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.confirmation_number_outlined, 
                       size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No tienes tickets',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.go('/events'),
                    child: const Text('Ver eventos disponibles'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(myTicketsProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return TicketCard(
                  ticket: ticket,
                  onTap: () => context.go('/ticket-detail/${ticket.id}'),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(myTicketsProvider);
                },
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, 3),
    );
  }
}

// features/tickets/presentation/widgets/ticket_card.dart

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback onTap;

  const TicketCard({
    required this.ticket,
    required this.onTap,
    super.key,
  });

  Color _getStatusColor() {
    switch (ticket.status) {
      case 'confirmed':
        return Colors.green;
      case 'used':
        return Colors.grey;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  String _getStatusText() {
    switch (ticket.status) {
      case 'confirmed':
        return 'VÁLIDO';
      case 'used':
        return 'USADO';
      case 'cancelled':
        return 'CANCELADO';
      default:
        return 'PENDIENTE';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Event image thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(16),
              ),
              child: Container(
                width: 100,
                height: 120,
                color: Colors.grey[300],
                child: const Icon(Icons.event, size: 40, color: Colors.white),
              ),
            ),

            // Ticket info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event name + status badge
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ticket.eventName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _getStatusText(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Date
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, 
                                   size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(ticket.eventDate),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on, 
                                   size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            ticket.eventLocation,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Quantity
                    Text(
                      '${ticket.quantity} ticket${ticket.quantity > 1 ? 's' : ''}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Arrow
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      '', 'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic'
    ];
    return '${date.day} ${months[date.month]} · ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
```

**Diseño:**
- Logo naranja arriba (icono de soundwave)
- Título "Login" centrado
- 2 campos: Email y Contraseña
- Botón naranja "Iniciar sesión"
- Link "Crear cuenta" (no funcional en v0.1)
- Link "¿Olvidaste tu contraseña?" (no funcional)
- Bottom navigation bar con 5 iconos

**Código simplificado:**

```dart
// features/auth/presentation/pages/login_page.dart

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Navigate on success
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is Authenticated) {
        context.go('/events');
      } else if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message), backgroundColor: Colors.red),
        );
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.graphic_eq, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 48),

              // Title
              const Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),

              // Email field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: authState is Loading
                      ? null
                      : () {
                          ref.read(authProvider.notifier).login(
                                _emailController.text,
                                _passwordController.text,
                              );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: authState is Loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Iniciar sesión',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Create account (disabled)
              TextButton(
                onPressed: null,
                child: Text(
                  'Crear cuenta',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),

              // Forgot password (disabled)
              TextButton(
                onPressed: null,
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, 0),
    );
  }
}
```

---

### 4.2 Pantalla 2: LISTA DE EVENTOS

**Diseño:**
- AppBar negro con logo naranja y menú hamburguesa
- Lista vertical de tarjetas de eventos
- Cada tarjeta tiene:
  - Imagen de fondo (multitud en concierto)
  - Badge "NUEVO" naranja (opcional)
  - Nombre del evento
  - Fecha y hora
  - Ubicación (con icono)
  - Nombre del organizador (con icono)
- Bottom navigation bar activo en el icono central (naranja)

**Código simplificado:**

```dart
// features/events/presentation/pages/events_list_page.dart

class EventsListPage extends ConsumerWidget {
  const EventsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.graphic_eq, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: eventsAsync.when(
        data: (events) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(eventsProvider);
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return EventCard(
                event: event,
                showNewBadge: index == 0, // Primer evento tiene badge
                onTap: () => context.go('/events/${event.id}'),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, 2),
    );
  }
}

// features/events/presentation/widgets/event_card.dart

class EventCard extends StatelessWidget {
  final Event event;
  final bool showNewBadge;
  final VoidCallback onTap;

  const EventCard({
    required this.event,
    this.showNewBadge = false,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  event.imageUrl ?? 'https://via.placeholder.com/400x200',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (showNewBadge)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'NUEVO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      event.formattedDate,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      event.location,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      event.organizerName,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

---

### 4.3 Pantalla 3: DETALLE DEL EVENTO

**Diseño:**
- Imagen de fondo full-width
- Overlay blanco redondeado desde abajo
- Título del evento
- Ubicación (con icono pin)
- Mapa estático (placeholder con pin naranja)
- Sección "Duda información" (placeholder)
- Avatar del artista con nombre "Kaley Smith"
- Géneros: "R&B · Trap · Nuevo soul · Hip-Hop"
- Botón naranja "Comprar ticket" al final

**Código simplificado:**

```dart
// features/events/presentation/pages/event_detail_page.dart

class EventDetailPage extends ConsumerWidget {
  final String eventId;

  const EventDetailPage({required this.eventId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventDetailProvider(eventId));

    return Scaffold(
      body: eventAsync.when(
        data: (event) => Stack(
          children: [
            // Background image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 300,
              child: Image.network(
                event.imageUrl ?? 'https://via.placeholder.com/400x300',
                fit: BoxFit.cover,
              ),
            ),

            // White overlay with content
            DraggableScrollableSheet(
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(24),
                    children: [
                      // Title
                      Text(
                        event.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Location
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            event.location,
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Map placeholder
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Simulate map background
                            Opacity(
                              opacity: 0.3,
                              child: Image.network(
                                'https://via.placeholder.com/400x150',
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Pin
                            const Icon(
                              Icons.location_on,
                              color: Colors.orange,
                              size: 48,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Info section
                      const Text(
                        'Duda información',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.description,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 24),

                      // Artist info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.orange,
                            child: Text(
                              event.organizerName[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.organizerName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Organizador del evento',
                                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Buy button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            _showPurchaseDialog(context, ref, event);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Comprar ticket · ${event.formattedPrice}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            // Back button
            Positioned(
              top: 40,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _showPurchaseDialog(BuildContext context, WidgetRef ref, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comprar ticket'),
        content: const Text('¿Confirmar compra de 1 ticket?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(purchaseProvider.notifier).purchaseTicket(
                    eventId: event.id,
                    quantity: 1,
                  );
              
              // Navigate to success page
              final purchaseState = ref.read(purchaseProvider);
              if (purchaseState is PurchaseSuccess) {
                context.go('/ticket-purchased/${purchaseState.ticket.id}');
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
```

---

### 4.4 Pantalla 4: TICKET COMPRADO

**Diseño:**
- Header "Ticket comprado"
- Nombre del evento con badge "VÁLIDO" verde
- Fecha y hora
- Ubicación "Madison Square Garden"
- Información de asiento: Sector 102, Fila 12, Asiento 7
- QR Code grande en el centro
- Botón "Mostrar CR" (toggle)
- Botón "Descargar" con icono
- Bottom bar con botón "Descargar"

**Código simplificado:**

```dart
// features/tickets/presentation/pages/ticket_purchased_page.dart

class TicketPurchasedPage extends ConsumerWidget {
  final String ticketId;

  const TicketPurchasedPage({required this.ticketId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Simulando ticket data (en realidad vendría del provider)
    final purchaseState = ref.watch(purchaseProvider);
    
    if (purchaseState is! PurchaseSuccess) {
      return const Scaffold(
        body: Center(child: Text('Error cargando ticket')),
      );
    }

    final ticket = purchaseState.ticket;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Ticket comprado', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/events'),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Event name with badge
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      ticket.eventName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'VÁLIDO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Date
              Text(
                ticket.eventDate.toString(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),

              // Location
              Text(
                ticket.eventLocation,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Seat info (simulado)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SeatInfo(label: 'Sector', value: '102'),
                  _SeatInfo(label: 'Fila', value: '12'),
                  _SeatInfo(label: 'Asiento', value: '7'),
                ],
              ),
              const SizedBox(height: 32),

              // QR Code
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code, size: 120, color: Colors.grey[800]),
                      Text(
                        ticket.id.substring(0, 8),
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Mostrar CR'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text('Descargar'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download),
            label: const Text('Descargar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SeatInfo extends StatelessWidget {
  final String label;
  final String value;

  const _SeatInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
```

---

## 5. PROVIDERS CON RIVERPOD GENERATOR

### 5.1 Auth Provider

```dart
// features/auth/presentation/providers/auth_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.authenticated(User user) = Authenticated;
  const factory AuthState.error(String message) = AuthError;
}

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();

    try {
      final usecase = ref.read(loginUsecaseProvider);
      final user = await usecase.call(email: email, password: password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
```

---

### 5.2 Events Provider

```dart
// features/events/presentation/providers/events_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_provider.g.dart';

@riverpod
Future<List<Event>> events(EventsRef ref) async {
  final usecase = ref.read(getEventsUsecaseProvider);
  return await usecase.call();
}

@riverpod
Future<Event> eventDetail(EventDetailRef ref, String eventId) async {
  final usecase = ref.read(getEventByIdUsecaseProvider);
  return await usecase.call(eventId: eventId);
}
```

---

### 5.3 Tickets Providers

```dart
// features/tickets/presentation/providers/purchase_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'purchase_provider.g.dart';

@freezed
class PurchaseState with _$PurchaseState {
  const factory PurchaseState.initial() = PurchaseInitial;
  const factory PurchaseState.loading() = PurchaseLoading;
  const factory PurchaseState.success(Ticket ticket) = PurchaseSuccess;
  const factory PurchaseState.error(String message) = PurchaseError;
}

@riverpod
class Purchase extends _$Purchase {
  @override
  PurchaseState build() {
    return const PurchaseState.initial();
  }

  Future<void> purchaseTicket({
    required String eventId,
    required int quantity,
  }) async {
    state = const PurchaseState.loading();

    try {
      final usecase = ref.read(purchaseTicketUsecaseProvider);
      final ticket = await usecase.call(eventId: eventId, quantity: quantity);
      state = PurchaseState.success(ticket);
      
      // Invalidar eventos y mis tickets
      ref.invalidate(eventsProvider);
      ref.invalidate(myTicketsProvider);
    } catch (e) {
      state = PurchaseState.error(e.toString());
    }
  }
}

// features/tickets/presentation/providers/my_tickets_provider.dart

@riverpod
Future<List<Ticket>> myTickets(MyTicketsRef ref) async {
  final usecase = ref.read(getUserTicketsUsecaseProvider);
  return await usecase.call();
}
```

---

## 6. ROUTING

```dart
// core/config/app_router.dart

import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuthenticated = authState is Authenticated;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoginRoute) {
        return '/login';
      }
      if (isAuthenticated && isLoginRoute) {
        return '/events';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/events',
        builder: (context, state) => const EventsListPage(),
      ),
      GoRoute(
        path: '/events/:id',
        builder: (context, state) {
          final eventId = state.pathParameters['id']!;
          return EventDetailPage(eventId: eventId);
        },
      ),
      GoRoute(
        path: '/my-tickets',
        builder: (context, state) => const MyTicketsPage(),
      ),
      GoRoute(
        path: '/ticket-detail/:id',
        builder: (context, state) {
          final ticketId = state.pathParameters['id']!;
          return TicketDetailPage(ticketId: ticketId);
        },
      ),
      GoRoute(
        path: '/ticket-purchased/:id',
        builder: (context, state) {
          final ticketId = state.pathParameters['id']!;
          return TicketPurchasedPage(ticketId: ticketId);
        },
      ),
    ],
  );
});
```

---

## 7. THEME

```dart
// core/theme/app_theme.dart

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.orange,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
```

---

## 8. DEPENDENCIES

```yaml
name: meet2go_app
description: Meet2Go - Prueba Técnica

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  
  # Routing
  go_router: ^13.0.0
  
  # Network
  dio: ^5.4.0
  
  # Storage
  flutter_secure_storage: ^9.0.0
  
  # Code Generation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  
  # Utils
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  
  # Code Generation
  build_runner: ^2.4.7
  riverpod_generator: ^2.3.11
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  flutter_lints: ^3.0.0
```

---

## 9. BUILD RUNNER COMMANDS

```bash
# Generar código
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## 10. CHECKLIST (2 horas)

### Fase 1: Setup (20 min)
- [ ] Crear proyecto Flutter
- [ ] Instalar dependencias
- [ ] Crear estructura de carpetas
- [ ] Setup Riverpod + Freezed
- [ ] Configurar theme

### Fase 2: Core (15 min)
- [ ] Dio client
- [ ] Secure storage
- [ ] Router con go_router
- [ ] API config

### Fase 3: Auth Feature (20 min)
- [ ] User entity + model (Freezed)
- [ ] Auth repository + datasource
- [ ] Login usecase
- [ ] Auth provider (Riverpod Generator)
- [ ] Login page UI

### Fase 4: Events Feature (25 min)
- [ ] Event entity + model (Freezed)
- [ ] Events repository + datasource
- [ ] Get events usecase
- [ ] Events provider
- [ ] Events list page
- [ ] Event detail page

### Fase 5: Tickets Feature (30 min)
- [ ] Ticket entity + model (Freezed)
- [ ] Tickets repository + datasource
- [ ] Purchase usecase
- [ ] Get user tickets usecase
- [ ] Purchase provider
- [ ] My tickets provider
- [ ] Ticket purchased page (confirmación)
- [ ] My tickets page (lista)
- [ ] Ticket card widget

### Fase 6: Testing (10 min)
- [ ] Probar flujo completo
- [ ] Corregir errores
- [ ] Screenshots

---

## 11. README PARA ENTREGA

```markdown
# Meet2Go App - Prueba Técnica

## Arquitectura
Clean Architecture con Feature-First:
- **Data:** Models (Freezed), Repositories, DataSources
- **Domain:** Entities, UseCases, Repository Interfaces
- **Presentation:** Pages, Widgets, Providers (Riverpod Generator)

## Pantallas
1. Login (auth simple)
2. Lista de eventos (ver todos)
3. Detalle de evento (info + comprar)
4. Ticket comprado (confirmación con QR)
5. Mis tickets (lista de tickets comprados)

## Tech Stack
- Riverpod Generator (state management)
- Freezed (immutable models)
- Go Router (navigation)
- Dio (networking)

## Instalación
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## Decisiones
- 5 pantallas (foco en arquitectura completa)
- Freezed + Riverpod Generator (reducir boilerplate)
- Sin registro visible (backend lo tiene)
- QR simulado (placeholder)
- Pantalla "Mis Tickets" conectada al backend
```

---

**Versión:** 0.1.0 ULTRA-SIMPLIFICADA  
**Tiempo estimado:** 2 horas  
**Autor:** Juan Carlos Jarrín
