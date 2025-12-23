import 'package:flutter/material.dart';
import '../../data/models/ticket_model.dart';

class TicketQRCode extends StatelessWidget {
  final TicketModel ticket;

  const TicketQRCode({
    super.key,
    required this.ticket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 8),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code,
            size: 140,
            color: Colors.grey[800],
          ),
          const SizedBox(height: 8),
          Text(
            ticket.id.substring(0, 8).toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}