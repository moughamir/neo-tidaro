import 'package:core/core.dart';

Future<void> initializeServices(AppConfig config) async {
  CoreLogger.initialization('Initializing services');

  try {
    await initServiceLocator(config: config);
    CoreLogger.initialization('Service locator initialized');

    CoreLogger.network(
      'Supabase client initialized',
      details: config.supabaseUrl,
    );

    CoreLogger.initialization('All services initialized successfully');
  } catch (error, stackTrace) {
    CoreLogger.error(
      'Service initialization failed',
      error: error,
      stackTrace: stackTrace,
      tag: 'DI',
    );
    rethrow;
  }
}
