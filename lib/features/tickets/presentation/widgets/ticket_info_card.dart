import 'package:flutter/material.dart';
import '../../data/models/ticket_model.dart';
import 'info_column.dart';

class TicketInfoCard extends StatelessWidget {
  final TicketModel ticket;

  const TicketInfoCard({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InfoColumn(
            label: 'Cantidad',
            value: ticket.quantity.toString(),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          InfoColumn(
            label: 'Total',
            value: ticket.formattedTotalPrice,
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          InfoColumn(
            label: 'Ticket ID',
            value: '#${ticket.id.substring(0, 6)}',
          ),
        ],
      ),
    );
  }
}