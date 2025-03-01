import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

class FailureMessages {
  static const String serverError =
      'Server error occurred. Please try again later.';
  static const String connectionError =
      'No internet connection. Please check your network.';
  static const String cacheError = 'Failed to load cached data.';
  static const String unexpectedError =
      'Unexpected error occurred. Please try again.';
}
