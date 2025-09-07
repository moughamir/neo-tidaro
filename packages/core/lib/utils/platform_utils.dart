import 'package:flutter/foundation.dart';

/// A utility class for checking the current platform and initializing platform-specific features.
///
/// This class provides a set of static getters to easily determine whether the
/// application is running on a desktop, mobile, or web platform. It also
/// includes specific checks for each operating system (Android, iOS, Windows,
/// Linux, macOS).
///
/// The checks are based on `kIsWeb` and `defaultTargetPlatform` from Flutter's
/// `foundation` library.
///
/// ## Usage
///
/// ```dart
/// if (PlatformUtils.isDesktop) {
///   // Run desktop-specific code
/// }
///
/// if (PlatformUtils.isAndroid) {
///   // Run Android-specific code
/// }
/// ```
class PlatformUtils {
  PlatformUtils._(); // Private constructor to prevent instantiation

  /// Returns `true` if the application is running on the web.
  static bool get isWeb => kIsWeb;

  /// Returns `true` if the application is running on a desktop platform.
  ///
  /// A desktop platform is considered to be Windows, Linux, or macOS.
  /// This is `false` if the application is running on the web.
  static bool get isDesktop =>
      !isWeb &&
      const [
        TargetPlatform.windows,
        TargetPlatform.linux,
        TargetPlatform.macOS,
      ].contains(defaultTargetPlatform);

  /// Returns `true` if the application is running on a mobile platform.
  ///
  /// A mobile platform is considered to be Android or iOS.
  /// This is `false` if the application is running on the web.
  static bool get isMobile =>
      !isWeb &&
      const [
        TargetPlatform.android,
        TargetPlatform.iOS,
      ].contains(defaultTargetPlatform);

  /// Returns `true` if the application is running on Android.
  /// This is `false` if the application is running on the web.
  static bool get isAndroid =>
      !isWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Returns `true` if the application is running on iOS.
  /// This is `false` if the application is running on the web.
  static bool get isIOS =>
      !isWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Returns `true` if the application is running on Windows.
  /// This is `false` if the application is running on the web.
  static bool get isWindows =>
      !isWeb && defaultTargetPlatform == TargetPlatform.windows;

  /// Returns `true` if the application is running on Linux.
  /// This is `false` if the application is running on the web.
  static bool get isLinux =>
      !isWeb && defaultTargetPlatform == TargetPlatform.linux;

  /// Returns `true` if the application is running on macOS.
  /// This is `false` if the application is running on the web.
  static bool get isMacOS =>
      !isWeb && defaultTargetPlatform == TargetPlatform.macOS;

  /// Returns a human-readable platform name
  static String get platformName {
    if (isWeb) return 'Web';
    if (isAndroid) return 'Android';
    if (isIOS) return 'iOS';
    if (isWindows) return 'Windows';
    if (isLinux) return 'Linux';
    if (isMacOS) return 'macOS';
    return 'Unknown';
  }

  /// Initializes platform-specific features for Neo-Tidaro apps
  /// This includes basic platform detection and logging
  static Future<void> initialize() async {
    if (kDebugMode) {
      debugPrint('🔍 Platform detected: $platformName');
      debugPrint('🔍 Platform capabilities:');
      debugPrint('  - Desktop: $isDesktop');
      debugPrint('  - Mobile: $isMobile');
      debugPrint('  - Web: $isWeb');
    }

    // Platform-specific initialization can be added here
    // For example: window management, system theme loading, etc.
    
    // Simulate platform initialization delay
    await Future.delayed(const Duration(milliseconds: 50));
    
    if (kDebugMode) {
      debugPrint('✅ Platform initialization completed');
    }
  }

  /// Returns platform-specific configuration values
  static Map<String, dynamic> getPlatformConfig() {
    return {
      'platform': platformName,
      'isDesktop': isDesktop,
      'isMobile': isMobile,
      'isWeb': isWeb,
      'supportsWindowManagement': isDesktop,
      'supportsNotifications': !isWeb,
      'supportsFileSystem': !isWeb,
    };
  }
}
