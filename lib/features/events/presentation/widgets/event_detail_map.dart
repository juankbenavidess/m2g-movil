import 'package:flutter/material.dart';

class EventDetailMap extends StatelessWidget {
  const EventDetailMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: Colors.orange,
            size: 60,
          ),
        ],
      ),
    );
  }
}