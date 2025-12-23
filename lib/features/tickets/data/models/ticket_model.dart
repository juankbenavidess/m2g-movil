import 'package:intl/intl.dart';

class TicketModel {
  final String id;
  final String eventId;
  final int quantity;
  final int totalPrice;
  final String status;
  final DateTime purchaseDate;

  const TicketModel({
    required this.id,
    required this.eventId,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.purchaseDate,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      quantity: json['quantity'] as int,
      totalPrice: json['totalPrice'] as int,
      status: json['status'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'status': status,
      'purchaseDate': purchaseDate.toIso8601String(),
    };
  }

  TicketModel copyWith({
    String? id,
    String? eventId,
    int? quantity,
    int? totalPrice,
    String? status,
    DateTime? purchaseDate,
  }) {
    return TicketModel(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      purchaseDate: purchaseDate ?? this.purchaseDate,
    );
  }

  String get formattedTotalPrice => '\$${(totalPrice / 100).toStringAsFixed(2)}';

  String get formattedPurchaseDate {
    return DateFormat('dd/MM/yyyy · HH:mm').format(purchaseDate);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TicketModel &&
        other.id == id &&
        other.eventId == eventId &&
        other.quantity == quantity &&
        other.totalPrice == totalPrice &&
        other.status == status &&
        other.purchaseDate == purchaseDate;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      eventId,
      quantity,
      totalPrice,
      status,
      purchaseDate,
    );
  }

  @override
  String toString() {
    return 'TicketModel(id: $id, eventId: $eventId, quantity: $quantity, totalPrice: $totalPrice, status: $status, purchaseDate: $purchaseDate)';
  }
}
