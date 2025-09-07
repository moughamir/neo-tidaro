import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:tidash/get_app_config.dart';
import 'package:tidash/initialize_platform.dart';
import 'package:tidash/initialize_services.dart';

import 'app/app.dart';
import 'package:ui_kit/ui_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    CoreLogger.lifecycle('TiDash startup initiated');

    runApp(const LoadingApp(message: 'Initializing TiDash...'));

    await initializePlatform();

    final AppConfig config = getAppConfig();

    await initializeServices(config);

    CoreLogger.initialization('TiDash initialized successfully');

    runApp(
      const MaterialApp(
        title: 'TiDash',
        home: Scaffold(body: Center(child: TiDashApp())),
      ),
    );
  } catch (error, stackTrace) {
    CoreLogger.fatal(
      'Fatal error during TiDash initialization',
      error: error,
      stackTrace: stackTrace,
      tag: 'MAIN',
    );

    runApp(ErrorApp(error: error, stackTrace: stackTrace, appName: 'TiDash'));
  }
}
