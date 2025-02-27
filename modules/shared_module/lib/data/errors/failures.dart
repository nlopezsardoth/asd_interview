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

class LocalFailure extends Failure {
  LocalFailure({required super.message});
}

class QrFailure extends Failure {
  QrFailure({required super.message});
}