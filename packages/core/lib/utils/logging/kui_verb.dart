import 'dart:developer' as developer;

/// A logging utility that provides standardized logging capabilities.
///
/// This class offers various log levels and formatting options to make
/// debugging and monitoring easier across the application.
class KuiVerb {
  // Private constructor to prevent instantiation
  KuiVerb._();

  // Log levels
  static const int _verbose = 0;
  static const int _debug = 1;
  static const int _info = 2;
  static const int _warning = 3;
  static const int _error = 4;
  static const int _wtf = 5;  // What a Terrible Failure
  
  // Current minimum log level (can be changed at runtime)
  static int _minLogLevel = _debug;

  /// Sets the minimum log level.
  ///
  /// Logs below this level will not be displayed.
  /// 0: Verbose, 1: Debug, 2: Info, 3: Warning, 4: Error, 5: WTF
  static void setMinLogLevel(int level) {
    _minLogLevel = level;
  }

  /// Logs a verbose message.
  static void verbose(
    String message, {
    String tag = 'VERBOSE',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      tag: tag,
      level: _verbose,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs a debug message.
  static void debug(
    String message, {
    String tag = 'DEBUG',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      tag: tag,
      level: _debug,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs an info message.
  static void info(
    String message, {
    String tag = 'INFO',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      tag: tag,
      level: _info,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs a warning message.
  static void warning(
    String message, {
    String tag = 'WARNING',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      tag: tag,
      level: _warning,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs an error message.
  static void error(
    String message, {
    String tag = 'ERROR',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      tag: tag,
      level: _error,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Logs a catastrophic failure (What a Terrible Failure).
  static void wtf(
    String message, {
    String tag = 'WTF',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      message,
      tag: tag,
      level: _wtf,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Internal logging function.
  static void _log(
    String message, {
    required String tag,
    required int level,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (level < _minLogLevel) {
      return;
    }

    final String levelStr = _getLevelString(level);
    final String errorStr = error != null ? '\nERROR: $error' : '';
    final String stackTraceStr = stackTrace != null ? '\n$stackTrace' : '';
    
    developer.log(
      '[$levelStr] [$tag] $message$errorStr$stackTraceStr',
      name: 'KuiVerb',
      level: level,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Converts a log level to its string representation.
  static String _getLevelString(int level) {
    switch (level) {
      case _verbose:
        return 'VERBOSE';
      case _debug:
        return 'DEBUG';
      case _info:
        return 'INFO';
      case _warning:
        return 'WARNING';
      case _error:
        return 'ERROR';
      case _wtf:
        return 'WTF';
      default:
        return 'UNKNOWN';
    }
  }
}
