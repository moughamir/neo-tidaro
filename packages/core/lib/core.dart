/// Core package for Neo-Tidaro applications
///
/// This package provides core functionality that can be used independently
/// from UI concerns while working well with shared, languist, and uikit packages.
library;

// Utils exports (from shared package)
export 'package:shared/utils/failures/failure.dart';
export 'package:shared/utils/type_defs.dart';

// Config exports
export 'config/app_config.dart';
// DI exports
export 'di/service_locator.dart';
// Network exports
export 'network/supabase_service.dart';
// Core utilities exports
export 'utils/logger.dart';
export 'utils/platform_utils.dart';
