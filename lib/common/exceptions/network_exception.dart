import 'package:weathertrack/common/exceptions/network_exception_type.dart';

export 'package:weathertrack/common/exceptions/network_exception_type.dart';

class NetworkException implements Exception {
  final NetworkExceptionType type;
  final String message;
  final String service;

  NetworkException({
    this.service = 'NetworkException',
    required this.type,
    required this.message,
  });

  @override
  String toString() => '$service(type: $type, message: $message)';
}
