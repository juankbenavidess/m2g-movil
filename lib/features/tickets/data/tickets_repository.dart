import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/api_config.dart';
import '../../../core/network/dio_client.dart';
import 'models/ticket_model.dart';

class TicketsRepository {
  final DioClient _dioClient;

  TicketsRepository(this._dioClient);

  Future<TicketModel> purchaseTicket({
    required String eventId,
    required int quantity,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConfig.purchaseTicketEndpoint,
        data: {'eventId': eventId, 'quantity': quantity},
      );

      return TicketModel.fromJson(response.data['data'] ?? response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TicketModel>> getMyTickets() async {
    try {
      final response = await _dioClient.get(ApiConfig.myTicketsEndpoint);

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => TicketModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<TicketModel> getTicketById(String id) async {
    try {
      // Get all user tickets since there's no individual ticket endpoint
      final tickets = await getMyTickets();

      // Find the ticket by ID
      final ticket = tickets.firstWhere(
        (ticket) => ticket.id == id,
        orElse: () => throw Exception('Ticket not found'),
      );

      return ticket;
    } catch (e) {
      rethrow;
    }
  }
}

// Provider
final ticketsRepositoryProvider = Provider<TicketsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TicketsRepository(dioClient);
});
