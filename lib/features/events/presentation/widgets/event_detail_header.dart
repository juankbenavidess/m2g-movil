import 'package:flutter/material.dart';
import '../../data/models/event_model.dart';

class EventDetailHeader extends StatelessWidget {
  final EventModel event;

  const EventDetailHeader({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 350,
          child: Image.network(
            event.imageUrl ?? 'https://via.placeholder.com/400x350',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.event,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),

        // Gradient overlay
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 350,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}