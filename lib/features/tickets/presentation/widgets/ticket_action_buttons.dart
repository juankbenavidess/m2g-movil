import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TicketActionButtons extends StatelessWidget {
  const TicketActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Share and Download buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement share functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Función disponible próximamente'),
                    ),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text('Compartir'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement download functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Función disponible próximamente'),
                    ),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Descargar'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // View all tickets button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.go('/my-tickets'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Ver mis tickets'),
          ),
        ),
      ],
    );
  }
}