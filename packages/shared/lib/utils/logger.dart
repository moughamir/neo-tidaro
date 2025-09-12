import 'package:logging/logging.dart';

/// A utility class for application-wide logging.
///
/// This class provides a centralized way to log messages with different severity levels
/// throughout the application. It wraps the `logging` package for consistent logging.
class CoreLogger {
  static final Logger _logger = Logger('NeoTidaro');
  static bool _isInitialized = false;

  /// Initializes the logger with the specified log level.
  ///
  /// This should be called once at application startup.
  static void initialize({Level level = Level.INFO}) {
    if (_isInitialized) return;

    // Configure the logger
    Logger.root.level = level;
    Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}');
      if (record.error != null) {
        // ignore: avoid_print
        print('Error: ${record.error}');
      }
      if (record.stackTrace != null) {
        // ignore: avoid_print
        print('Stack trace: ${record.stackTrace}');
      }
    });

    _isInitialized = true;
  }

  /// Logs a message at the FINE level.
  static void fine(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.fine(message, error, stackTrace);
  }

  /// Logs a message at the INFO level.
  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.info(message, error, stackTrace);
  }

  /// Logs a message at the WARNING level.
  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  /// Logs a message at the SEVERE level.
  static void severe(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  /// Logs a message at the SEVERE level (alias for [severe]).
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  /// Logs a message at the INFO level for network-related operations.
  static void network(String message) {
    _logger.info('[NETWORK] $message');
  }

  /// Logs a message at the FINE level for database operations.
  static void database(String message) {
    _logger.fine('[DATABASE] $message');
  }

  /// Logs a message at the INFO level for state changes.
  static void state(String message) {
    _logger.info('[STATE] $message');
  }

  /// Logs a message at the FINE level for API calls.
  static void api(String message) {
    _logger.fine('[API] $message');
  }

  /// Logs a message at the WARNING level for deprecated functionality.
  static void deprecated(String message) {
    _logger.warning('[DEPRECATED] $message');
  }
}
