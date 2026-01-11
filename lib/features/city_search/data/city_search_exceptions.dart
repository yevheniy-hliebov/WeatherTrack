enum CityExceptionType { network, server, notFound, unknown }

class CitySearchException implements Exception {
  final CityExceptionType type;
  final String message;

  CitySearchException({required this.type, required this.message});

  @override
  String toString() => 'CitySearchException(type: $type, message: $message)';
}
