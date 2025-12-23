import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/tickets_repository.dart';
import '../../data/models/ticket_model.dart';
import '../../../events/presentation/providers/events_provider.dart';

part 'purchase_provider.g.dart';

sealed class PurchaseState {
  const PurchaseState();
}

class PurchaseInitial extends PurchaseState {
  const PurchaseInitial();
}

class PurchaseLoading extends PurchaseState {
  const PurchaseLoading();
}

class PurchaseSuccess extends PurchaseState {
  final TicketModel ticket;
  const PurchaseSuccess(this.ticket);
}

class PurchaseError extends PurchaseState {
  final String message;
  const PurchaseError(this.message);
}

@riverpod
class Purchase extends _$Purchase {
  @override
  PurchaseState build() {
    return const PurchaseInitial();
  }

  Future<void> purchaseTicket({
    required String eventId,
    required int quantity,
  }) async {
    state = const PurchaseLoading();

    try {
      final repository = ref.read(ticketsRepositoryProvider);
      final ticket = await repository.purchaseTicket(
        eventId: eventId,
        quantity: quantity,
      );

      state = PurchaseSuccess(ticket);

      // Invalidate events and my tickets to refresh data
      ref.invalidate(eventsProvider);
      ref.invalidate(myTicketsProvider);
    } catch (e) {
      state = PurchaseError(e.toString());
    }
  }

  void reset() {
    state = const PurchaseInitial();
  }
}

@riverpod
Future<List<TicketModel>> myTickets(Ref ref) async {
  final repository = ref.watch(ticketsRepositoryProvider);
  return await repository.getMyTickets();
}

@riverpod
Future<TicketModel> ticketDetail(Ref ref, String ticketId) async {
  final repository = ref.watch(ticketsRepositoryProvider);
  return await repository.getTicketById(ticketId);
}

/// Helper provider to get event details for a given eventId
/// Use this in ticket widgets to fetch event info
@riverpod
Future<dynamic> eventForTicket(Ref ref, String eventId) async {
  return ref.watch(eventDetailProvider(eventId).future);
}
