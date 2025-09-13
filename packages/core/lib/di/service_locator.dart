import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../config/app_config.dart';
import '../network/supabase_service.dart';
import '../utils/logger.dart';

/// Global GetIt instance for service location and dependency injection.
final getIt = GetIt.instance;

/// Initializes the service locator with all required dependencies.
Future<void> initServiceLocator({
  AppConfig? config,
}) async {
  CoreLogger.initialization('Initializing service locator');

  try {
    // Load environment variables if .env file exists
    try {
      await dotenv.load(fileName: '.env');
      CoreLogger.config('Environment variables loaded from .env file');
    } catch (e) {
      CoreLogger.warning('No .env file found, using default configuration', tag: 'CONFIG');
    }

    // Register the app configuration
    if (config != null) {
      getIt.registerSingleton<AppConfig>(config);
      CoreLogger.config('App configuration registered', details: config.appName);
    } else {
      // Default to development environment if not specified
      final defaultConfig = AppConfig.development();
      getIt.registerSingleton<AppConfig>(defaultConfig);
      CoreLogger.config('Default development configuration registered');
    }

    // Register core services as lazy singletons
    getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());
    CoreLogger.initialization('SupabaseService registered as lazy singleton');

    // Initialize services that require async initialization
    final appConfig = getIt<AppConfig>();
    
    CoreLogger.network('Initializing Supabase client', details: appConfig.supabaseUrl);
    await SupabaseService.init(
      appConfig.supabaseUrl, 
      appConfig.supabaseAnonKey,
    );
    CoreLogger.network('Supabase client initialized successfully');

    CoreLogger.initialization('Service locator initialization completed');
  } catch (error, stackTrace) {
    CoreLogger.error(
      'Service locator initialization failed',
      error: error,
      stackTrace: stackTrace,
      tag: 'DI',
    );
    rethrow;
  }
}

/// Resets the service locator for testing purposes.
Future<void> resetServiceLocator() async {
  CoreLogger.initialization('Resetting service locator for testing');
  await getIt.reset();
  CoreLogger.initialization('Service locator reset completed');
}
