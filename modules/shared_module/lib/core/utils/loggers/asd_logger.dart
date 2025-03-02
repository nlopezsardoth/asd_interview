import 'package:logger/logger.dart';

class AsdLogger {
  static final AsdLogger _singleton = AsdLogger._internal();

  factory AsdLogger() {
    return _singleton;
  }

  AsdLogger._internal();

  Logger getLogger() {
    return Logger(
      printer: PrettyPrinter(
        // number of method calls to be displayed
        methodCount: 2,
        // number of method calls if stacktrace is provided
        errorMethodCount: 8,
        // width of the output
        lineLength: 120,
        // Colorful log messages
        colors: true,
        // Print an emoji for each log message
        printEmojis: true,
        // Should each log print contain a timestamp
        dateTimeFormat: DateTimeFormat.none,
      ),
    );
  }
}