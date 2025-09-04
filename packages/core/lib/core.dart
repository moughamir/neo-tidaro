/// Core package for Neo-Tidaro applications
///
/// This package provides core functionality that can be used independently
/// from UI concerns while working well with shared, languist, and uikit packages.
library core;

// Utils exports (from shared package)
export 'package:shared/utils/failures/failure.dart';
export 'package:shared/utils/type_defs.dart';
export 'utils/logging/kui_verb.dart';

// Config exports
export 'config/app_config.dart';

// DI exports
export 'di/service_locator.dart';
