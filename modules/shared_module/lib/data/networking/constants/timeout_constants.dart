final TimeoutConstants timeoutConstants = TimeoutConstants();

class TimeoutConstants {
  Duration connectTimeout = const Duration(seconds: 30);
  Duration receiveTimeout = const Duration(seconds: 30);
  Duration sendTimeout = const Duration(seconds: 30);
}