import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/events/presentation/pages/events_list_page.dart';
import '../../features/events/presentation/pages/event_detail_page.dart';
import '../../features/tickets/presentation/pages/ticket_purchased_page.dart';
import '../../features/tickets/presentation/pages/my_tickets_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authState is AuthAuthenticated;
      final isLoginRoute = state.matchedLocation == '/login';

      // If not authenticated and trying to access protected route
      if (!isAuthenticated && !isLoginRoute) {
        return '/login';
      }

      // If authenticated and on login page, redirect to events
      if (isAuthenticated && isLoginRoute) {
        return '/events';
      }

      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/events',
        builder: (context, state) => const EventsListPage(),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final eventId = state.pathParameters['id']!;
              return EventDetailPage(eventId: eventId);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/my-tickets',
        builder: (context, state) => const MyTicketsPage(),
      ),
      GoRoute(
        path: '/ticket-purchased/:id',
        builder: (context, state) {
          final ticketId = state.pathParameters['id']!;
          return TicketPurchasedPage(ticketId: ticketId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Página no encontrada',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/events'),
              child: const Text('Ir a inicio'),
            ),
          ],
        ),
      ),
    ),
  );
});
