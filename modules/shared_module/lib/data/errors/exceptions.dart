class LocalDatabaseException implements Exception {
  const LocalDatabaseException({required this.message});

  final String message;

  @override
  String toString() {
    return 'LocalDatabaseException{message: $message}';
  }
}