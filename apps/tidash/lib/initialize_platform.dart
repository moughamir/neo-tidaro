import 'package:core/core.dart';

Future<void> initializePlatform() async {
  try {
    await PlatformUtils.initialize();

    final Map<String, dynamic> platformConfig =
        PlatformUtils.getPlatformConfig();
    CoreLogger.platform(
      'Platform configuration loaded',
      details: platformConfig.toString(),
    );

    CoreLogger.platform('Platform: ${PlatformUtils.platformName}');
    CoreLogger.platform('Desktop support: ${PlatformUtils.isDesktop}');
    CoreLogger.platform('Mobile support: ${PlatformUtils.isMobile}');
    CoreLogger.platform('Web support: ${PlatformUtils.isWeb}');
  } catch (error, stackTrace) {
    CoreLogger.warning(
      'Platform initialization warning',
      error: error,
      stackTrace: stackTrace,
      tag: 'PLATFORM',
    );
  }
}
