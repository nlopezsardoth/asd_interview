enum FailureCause { noInternetConnection, notFound, unknown }

abstract class Failure {
  Failure({required this.message, this.statusCode = -1});

  final String message;
  final int statusCode;

  @override
  String toString() {
    return '{ message: $message, statusCode: $statusCode }';
  }
}

class LocalStorageFailure extends Failure {
  LocalStorageFailure({required super.message});
}

class MoviesServerFailure extends Failure {
  MoviesServerFailure({required super.message});
}