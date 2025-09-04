import 'package:get_it/get_it.dart';

import '../config/app_config.dart';
import '../network/supabase_service.dart';

/// Global GetIt instance for service location and dependency injection.
final getIt = GetIt.instance;

/// Initializes the service locator with all required dependencies.
Future<void> initServiceLocator({
  AppConfig? config,
}) async {
  // Register the app configuration
  if (config != null) {
    getIt.registerSingleton<AppConfig>(config);
  } else {
    // Default to development environment if not specified
    getIt.registerSingleton<AppConfig>(AppConfig.development());
  }

  // Register core services as lazy singletons
  getIt.registerLazySingleton<SupabaseService>(() => SupabaseService());

  // Initialize services that require async initialization
  final appConfig = getIt<AppConfig>();
  
  await SupabaseService.init(
    appConfig.supabaseUrl, 
    appConfig.supabaseAnonKey,
  );
}

/// Resets the service locator for testing purposes.
Future<void> resetServiceLocator() async {
  await getIt.reset();
}
