/// A configuration class that holds environment-specific configuration.
///
/// This class is designed to be initialized at app startup with the
/// appropriate configuration for the current environment.
class AppConfig {
  /// The application name
  final String appName;
  
  /// The Supabase URL
  final String supabaseUrl;
  
  /// The Supabase anonymous key
  final String supabaseAnonKey;
  
  /// Whether the app is in debug mode
  final bool isDebug;
  
  /// The API base URL
  final String apiBaseUrl;
  
  /// Additional custom configuration values
  final Map<String, dynamic> _values;

  /// Creates an instance of [AppConfig] with the provided values.
  AppConfig({
    required this.appName,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    this.isDebug = false,
    this.apiBaseUrl = '',
    Map<String, dynamic>? values,
  }) : _values = values ?? {};

  /// Gets a custom configuration value by key.
  T? get<T>(String key) => _values[key] as T?;

  /// Factory constructor for development environment
  factory AppConfig.development() {
    return AppConfig(
      appName: 'Neo-Tidaro (Dev)',
      supabaseUrl: const String.fromEnvironment('SUPABASE_URL', 
          defaultValue: 'http://127.0.0.1:54321'),
      supabaseAnonKey: const String.fromEnvironment('SUPABASE_ANON_KEY', 
          defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0'),
      isDebug: true,
      apiBaseUrl: 'http://127.0.0.1:54321',
    );
  }

  /// Factory constructor for staging environment
  factory AppConfig.staging() {
    return AppConfig(
      appName: 'Neo-Tidaro (Staging)',
      supabaseUrl: const String.fromEnvironment('SUPABASE_URL'),
      supabaseAnonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
      isDebug: false,
      apiBaseUrl: 'https://api-staging.example.com',
    );
  }

  /// Factory constructor for production environment
  factory AppConfig.production() {
    return AppConfig(
      appName: 'Neo-Tidaro',
      supabaseUrl: const String.fromEnvironment('SUPABASE_URL'),
      supabaseAnonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
      isDebug: false,
      apiBaseUrl: 'https://api.example.com',
    );
  }
}

/// Global instance of the app configuration.
///
/// This should be initialized at app startup before any other services.
late AppConfig appConfig;
