class ApiConfig {
  static const String baseUrl = 'http://localhost:3000';

  // Auth endpoints
  static const String loginEndpoint = '/api/auth/login';
  static const String registerEndpoint = '/api/auth/register';

  // Events endpoints
  static const String eventsEndpoint = '/api/events';

  // Tickets endpoints
  static const String myTicketsEndpoint = '/api/tickets/my-tickets';
  static const String purchaseTicketEndpoint = '/api/tickets/purchase';

  // Health check
  static const String healthEndpoint = '/health';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}