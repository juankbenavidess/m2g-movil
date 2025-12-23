import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/purchase_provider.dart';
import '../widgets/ticket_purchase_header.dart';
import '../widgets/ticket_event_info.dart';
import '../widgets/ticket_info_card.dart';
import '../widgets/ticket_qr_code.dart';
import '../widgets/ticket_action_buttons.dart';

class TicketPurchasedPage extends ConsumerWidget {
  final String ticketId;

  const TicketPurchasedPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketDetailProvider(ticketId));

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Ticket comprado',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/my-tickets'),
        ),
      ),
      body: ticketAsync.when(
        data: (ticket) => _buildContent(context, ref, ticket),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 60, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, ticket) {
    final eventAsync = ref.watch(eventForTicketProvider(ticket.eventId));
    
    return eventAsync.when(
      data: (event) => _buildSuccessCard(context, ticket, event),
      loading: () => _buildSuccessCard(context, ticket, null),
      error: (error, stack) => _buildSuccessCard(context, ticket, null),
    );
  }

  Widget _buildSuccessCard(BuildContext context, ticket, dynamic event) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TicketPurchaseHeader(),
              const SizedBox(height: 32),
              TicketEventInfo(ticket: ticket, event: event),
              const SizedBox(height: 32),
              TicketInfoCard(ticket: ticket),
              const SizedBox(height: 32),
              TicketQRCode(ticket: ticket),
              const SizedBox(height: 32),
              const TicketActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

}
