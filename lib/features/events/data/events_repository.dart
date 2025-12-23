import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/api_config.dart';
import '../../../core/network/dio_client.dart';
import 'models/event_model.dart';

class EventsRepository {
  final DioClient _dioClient;

  EventsRepository(this._dioClient);

  Future<List<EventModel>> getEvents() async {
    try {
      final response = await _dioClient.get(ApiConfig.eventsEndpoint);

      final List<dynamic> data = response.data['data'] ?? response.data;
      return data.map((json) => EventModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<EventModel> getEventById(String id) async {
    try {
      // Get all events since there's no individual event endpoint
      final events = await getEvents();
      
      // Find the event by ID
      final event = events.firstWhere(
        (event) => event.id == id,
        orElse: () => throw Exception('Event not found'),
      );
      
      return event;
    } catch (e) {
      rethrow;
    }
  }
}

// Provider
final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EventsRepository(dioClient);
});
