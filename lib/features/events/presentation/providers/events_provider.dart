import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/events_repository.dart';
import '../../data/models/event_model.dart';

part 'events_provider.g.dart';

@riverpod
Future<List<EventModel>> events(Ref ref) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return await repository.getEvents();
}

@riverpod
Future<EventModel> eventDetail(Ref ref, String eventId) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return await repository.getEventById(eventId);
}
