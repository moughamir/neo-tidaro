/// Redux barrel file for easy imports
library redux;

// Core Redux
export 'package:flutter_redux/flutter_redux.dart';
export 'package:redux/redux.dart';
export 'package:redux_thunk/redux_thunk.dart';

// Application State
export 'app_state.dart';
export 'store/store.dart';

// Feature States
export 'auth/auth_state.dart';
export 'ui/ui_state.dart';
export 'dashboard/dashboard_state.dart';
export 'housekeeping/housekeeping_state.dart';

// Feature Actions
export 'actions/auth_actions.dart';
export 'ui/ui_actions.dart';
export 'actions/dashboard_actions.dart';
export 'actions/dashboard_auth_actions.dart';
export 'housekeeping/housekeeping_actions.dart';

// Feature Reducers
export 'reducers/app_reducer.dart';
export 'reducers/auth_reducer.dart';
export 'reducers/ui_reducer.dart';
export 'reducers/dashboard_reducer.dart';
export 'housekeeping/housekeeping_reducers.dart';

// Feature Selectors
export 'selectors/auth_selectors.dart';
export 'ui/ui_selectors.dart';
export 'selectors/dashboard_selectors.dart';
export 'housekeeping/housekeeping_selectors.dart';

// Middleware
export 'middleware/logging_middleware.dart';
export 'middleware/dashboard_auth_middleware.dart';
export 'housekeeping/housekeeping_middleware.dart';

// Domain Models
export 'housekeeping/housekeeping_models.dart';
