import 'package:flutter/material.dart';
import '../../data/models/event_model.dart';

class EventDetailDescription extends StatelessWidget {
  final EventModel event;

  const EventDetailDescription({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descripción',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          event.description,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}