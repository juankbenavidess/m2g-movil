import 'package:flutter/material.dart';
import '../../data/models/event_model.dart';

class EventDetailActionButton extends StatelessWidget {
  final EventModel event;
  final VoidCallback? onPressed;

  const EventDetailActionButton({
    super.key,
    required this.event,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: event.hasTicketsAvailable ? onPressed : null,
        child: Text(
          event.hasTicketsAvailable
              ? 'Comprar ticket · ${event.formattedPrice}'
              : 'Agotado',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}