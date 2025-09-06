import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

AppConfig getAppConfig() {
  AppConfig config;

  if (kDebugMode) {
    CoreLogger.config('Loading development configuration');
    config = AppConfig.development();
  } else if (const bool.fromEnvironment('STAGING', defaultValue: false)) {
    CoreLogger.config('Loading staging configuration');
    config = AppConfig.staging();
  } else {
    CoreLogger.config('Loading production configuration');
    config = AppConfig.production();
  }

  CoreLogger.config('App configuration loaded', details: config.appName);
  return config;
}
