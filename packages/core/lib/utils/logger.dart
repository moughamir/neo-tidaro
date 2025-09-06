import 'package:flutter/foundation.dart';

/// Enhanced logger for Neo-Tidaro applications
/// Provides consistent logging across all apps with optional tag emojis and structured output
class CoreLogger {
  CoreLogger._(); // Private constructor to prevent instantiation

  /// Tag emoji mappings for visual identification
  static const Map<String, String> _tagEmojis = {
    // Core system tags
    'MAIN': '🚀',
    'INIT': '⚙️',
    'CONFIG': '🔧',
    'PLATFORM': '🔍',
    'DI': '💉',
    
    // Network and API tags
    'API': '🌐',
    'NETWORK': '📡',
    'SUPABASE': '🔗',
    'HTTP': '📤',
    'WEBSOCKET': '🔌',
    
    // Authentication and security
    'AUTH': '🔑',
    'SECURITY': '🛡️',
    'TOKEN': '🎫',
    'SESSION': '👤',
    
    // Data and storage
    'DB': '🗄️',
    'CACHE': '💾',
    'STORAGE': '📦',
    'SYNC': '🔄',
    
    // UI and navigation
    'UI': '🖥️',
    'NAVIGATION': '🧭',
    'ROUTE': '🛤️',
    'THEME': '🎨',
    'WIDGET': '🧩',
    
    // Business logic
    'BOOKING': '📅',
    'PAYMENT': '💳',
    'NOTIFICATION': '🔔',
    'CHAT': '💬',
    'PROFILE': '👤',
    
    // Development and debugging
    'DEBUG': '🐛',
    'TEST': '🧪',
    'PERFORMANCE': '⚡',
    'MEMORY': '🧠',
    'ERROR': '❌',
    
    // System and lifecycle
    'LIFECYCLE': '🔄',
    'BACKGROUND': '⏰',
    'FOREGROUND': '🎯',
    'DISPOSE': '🗑️',
  };

  /// Level emoji mappings
  static const Map<String, String> _levelEmojis = {
    'debug': '🐛',
    'info': 'ℹ️',
    'warning': '⚠️',
    'error': '❌',
    'fatal': '💀',
  };

  /// Formats message with optional tag and/or level emojis
  static String _formatMessage(
    String message, {
    String? tag,
    String? level,
    bool showLevel = false,
  }) {
    final parts = <String>[];

    // Add level emoji if requested
    if (showLevel && level != null) {
      final levelEmoji = _levelEmojis[level] ?? '📝';
      parts.add(levelEmoji);
    }

    // Add tag emoji and label if provided
    if (tag != null) {
      final tagEmoji = _tagEmojis[tag.toUpperCase()] ?? '📝';
      parts.add('$tagEmoji [$tag]');
    }

    // Combine parts with message
    if (parts.isEmpty) return message;
    return '${parts.join(' ')} $message';
  }

  /// Log debug message with optional tag and level emojis
  static void debug(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
    bool showLevel = false,
  }) {
    if (kDebugMode) {
      final formattedMessage = _formatMessage(
        message,
        tag: tag,
        level: 'debug',
        showLevel: showLevel,
      );
      
      debugPrint(formattedMessage);
      
      if (error != null) {
        debugPrint('Error: $error');
      }
      
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

  /// Log info message with optional tag and level emojis
  static void info(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
    bool showLevel = false,
  }) {
    if (kDebugMode) {
      final formattedMessage = _formatMessage(
        message,
        tag: tag,
        level: 'info',
        showLevel: showLevel,
      );
      
      debugPrint(formattedMessage);
      
      if (error != null) {
        debugPrint('Error: $error');
      }
      
      if (stackTrace != null) {
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

  /// Log warning message with optional tag and level emojis
  static void warning(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
    bool showLevel = false,
  }) {
    final formattedMessage = _formatMessage(
      message,
      tag: tag,
      level: 'warning',
      showLevel: showLevel,
    );
    
    debugPrint(formattedMessage);
    
    if (error != null) {
      debugPrint('Error: $error');
    }
    
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// Log error message with optional tag and level emojis
  static void error(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
    bool showLevel = false,
  }) {
    final formattedMessage = _formatMessage(
      message,
      tag: tag,
      level: 'error',
      showLevel: showLevel,
    );
    
    debugPrint(formattedMessage);
    
    if (error != null) {
      debugPrint('Error: $error');
    }
    
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// Log fatal error message with optional tag and level emojis
  static void fatal(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
    bool showLevel = false,
  }) {
    final formattedMessage = _formatMessage(
      message,
      tag: tag,
      level: 'fatal',
      showLevel: showLevel,
    );
    
    debugPrint(formattedMessage);
    
    if (error != null) {
      debugPrint('Error: $error');
    }
    
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// Log app lifecycle events
  static void lifecycle(String event, {String? details}) {
    info(
      details != null ? '$event: $details' : event,
      tag: 'LIFECYCLE',
      showLevel: true,
    );
  }

  /// Log initialization steps
  static void initialization(String step, {String? details}) {
    info(
      details != null ? '$step: $details' : step,
      tag: 'INIT',
      showLevel: true,
    );
  }

  /// Log platform-specific information
  static void platform(String message, {String? details}) {
    info(
      details != null ? '$message: $details' : message,
      tag: 'PLATFORM',
      showLevel: true,
    );
  }

  /// Log configuration changes
  static void config(String change, {String? details}) {
    info(
      details != null ? '$change: $details' : change,
      tag: 'CONFIG',
      showLevel: true,
    );
  }

  /// Log network operations
  static void network(String operation, {String? details}) {
    debug(
      details != null ? '$operation: $details' : operation,
      tag: 'NETWORK',
      showLevel: true,
    );
  }

  /// Log authentication events
  static void auth(String event, {String? details}) {
    info(
      details != null ? '$event: $details' : event,
      tag: 'AUTH',
      showLevel: true,
    );
  }

  /// Log navigation events
  static void navigation(String action, {String? route}) {
    debug(
      route != null ? '$action: $route' : action,
      tag: 'NAVIGATION',
      showLevel: true,
    );
  }

  /// Log performance metrics
  static void performance(String metric, {String? value}) {
    debug(
      value != null ? '$metric: $value' : metric,
      tag: 'PERFORMANCE',
      showLevel: true,
    );
  }
}
