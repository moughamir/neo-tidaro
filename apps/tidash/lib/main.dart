import 'package:core/core.dart';
import 'package:tidash/get_app_config.dart';
import 'package:tidash/initialize_platform.dart';
import 'package:tidash/initialize_services.dart';
import 'package:ui_kit/ui_kit.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const TiDashBootstrap());
}

class TiDashBootstrap extends StatefulWidget {
  const TiDashBootstrap({super.key});

  @override
  State<TiDashBootstrap> createState() => _TiDashBootstrapState();
}

class _TiDashBootstrapState extends State<TiDashBootstrap> {
  bool _isInitialized = false;
  String? _error;
  StackTrace? _stackTrace;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      CoreLogger.lifecycle('TiDash startup initiated');

      // Ensure minimum loading time for better UX
      final Future<void> initializationFuture = _performInitialization();
      final Future<void> minimumLoadingTime = Future.delayed(
        const Duration(milliseconds: 15000),
      );

      await Future.wait([initializationFuture, minimumLoadingTime]);

      CoreLogger.initialization('TiDash initialized successfully');

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (error, stackTrace) {
      CoreLogger.fatal(
        'Fatal error during TiDash initialization',
        error: error,
        stackTrace: stackTrace,
        tag: 'MAIN',
      );

      if (mounted) {
        setState(() {
          _error = error.toString();
          _stackTrace = stackTrace;
        });
      }
    }
  }

  Future<void> _performInitialization() async {
    await initializePlatform();
    final AppConfig config = getAppConfig();
    await initializeServices(config);
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return ErrorApp(
        error: _error!,
        stackTrace: _stackTrace,
        appName: 'TiDash',
      );
    }

    if (!_isInitialized) {
      return const LoadingApp(
        message: 'Initializing TiDash...',
        subtitle: 'Setting up your dashboard experience',
      );
    }

    return const TiDashApp();
  }
}
