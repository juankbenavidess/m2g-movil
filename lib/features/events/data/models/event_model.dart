import 'package:intl/intl.dart';

class EventModel {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final String location;
  final int price;
  final String currency;
  final int availableTickets;
  final String organizerName;
  final String? imageUrl;

  const EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.location,
    required this.price,
    this.currency = 'MXN',
    required this.availableTickets,
    required this.organizerName,
    this.imageUrl,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      price: json['price'] as int,
      currency: json['currency'] as String? ?? 'MXN',
      availableTickets: json['availableTickets'] as int,
      organizerName: json['organizerName'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'price': price,
      'currency': currency,
      'availableTickets': availableTickets,
      'organizerName': organizerName,
      'imageUrl': imageUrl,
    };
  }

  EventModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? date,
    String? location,
    int? price,
    String? currency,
    int? availableTickets,
    String? organizerName,
    String? imageUrl,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      location: location ?? this.location,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      availableTickets: availableTickets ?? this.availableTickets,
      organizerName: organizerName ?? this.organizerName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  // Helper methods
  String get formattedPrice => '\$${(price / 100).toStringAsFixed(2)}';

  String get formattedDate {
    final months = [
      '',
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];
    return '${date.day} de ${months[date.month]} · ${DateFormat('HH:mm').format(date)}';
  }

  String get formattedDateTime {
    return DateFormat('dd/MM/yyyy · HH:mm').format(date);
  }

  bool get hasTicketsAvailable => availableTickets > 0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EventModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.date == date &&
        other.location == location &&
        other.price == price &&
        other.currency == currency &&
        other.availableTickets == availableTickets &&
        other.organizerName == organizerName &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      description,
      date,
      location,
      price,
      currency,
      availableTickets,
      organizerName,
      imageUrl,
    );
  }

  @override
  String toString() {
    return 'EventModel(id: $id, name: $name, description: $description, date: $date, location: $location, price: $price, currency: $currency, availableTickets: $availableTickets, organizerName: $organizerName, imageUrl: $imageUrl)';
  }
}
