/// Redux barrel file for easy imports
library redux;

// Core Redux
export 'package:flutter_redux/flutter_redux.dart';
export 'package:redux/redux.dart';
export 'package:redux_thunk/redux_thunk.dart';

// Application Redux exports
export 'app_state.dart';
export 'store/store.dart';

// Actions exports
export 'actions/actions.dart';

// Reducers exports
export 'reducers/app_reducer.dart';

// Selectors exports
export 'selectors/selectors.dart';

// Middleware exports
export 'middleware/middleware.dart';

// Auth exports
export 'auth/auth_state.dart';

export 'auth/auth_reducer.dart';
export 'middleware/auth_middleware.dart';

// UI exports
export 'ui/ui_state.dart';
export 'ui/ui_actions.dart';
export 'ui/ui_reducer.dart';

// Dashboard exports
export 'dashboard/dashboard_state.dart';
export 'dashboard/dashboard_actions.dart';
export 'dashboard/dashboard_reducer.dart';
export 'dashboard/dashboard_selectors.dart';
export 'dashboard/dashboard_middleware.dart';

// Feature Selectors
export 'selectors/auth_selectors.dart';
export 'ui/ui_selectors.dart';
export 'selectors/dashboard_selectors.dart';
export 'selectors/housekeeping_selectors.dart';

// Middleware
export 'middleware/logging_middleware.dart';
export 'middleware/dashboard_auth_middleware.dart';
export 'middleware/housekeeping_middleware.dart';

// Domain Models
export 'housekeeping/housekeeping_models.dart';
