import 'package:flutter/material.dart';
import '../../data/models/ticket_model.dart';

class TicketEventInfo extends StatelessWidget {
  final TicketModel ticket;
  final dynamic event;

  const TicketEventInfo({
    super.key,
    required this.ticket,
    required this.event,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'used':
        return Colors.grey;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'VÁLIDO';
      case 'used':
        return 'USADO';
      case 'cancelled':
        return 'CANCELADO';
      default:
        return 'PENDIENTE';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Event name with badge
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                event?.name ?? 'Cargando evento...',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: _getStatusColor(ticket.status),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getStatusText(ticket.status),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Date & Location
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today,
                    size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Text(
                  event?.formattedDate ?? '--',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on,
                    size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    event?.location ?? '--',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}