/// Redux barrel file for easy imports
library redux;

// State
export 'app_state.dart';
export 'auth/auth_state.dart';
export 'ui/ui_state.dart';
export 'dashboard/dashboard_state.dart';
export 'housekeeping/housekeeping_state.dart';

// Actions
export 'actions/auth_actions.dart';
export 'actions/ui_actions.dart';
export 'actions/dashboard_actions.dart';
export 'actions/dashboard_auth_actions.dart';
export 'housekeeping/housekeeping_actions.dart';

// Reducers
export 'reducers/app_reducer.dart';
export 'reducers/auth_reducer.dart';
export 'reducers/ui_reducer.dart';
export 'reducers/dashboard_reducer.dart';
export 'housekeeping/housekeeping_reducers.dart';

// Store
export 'store/store.dart';

// Selectors
export 'selectors/auth_selectors.dart';
export 'selectors/ui_selectors.dart';
export 'selectors/dashboard_selectors.dart';
export 'housekeeping/housekeeping_selectors.dart';

// Middleware
export 'middleware/logging_middleware.dart';
export 'middleware/dashboard_auth_middleware.dart';
export 'housekeeping/housekeeping_middleware.dart';

// Models
export 'housekeeping/housekeeping_models.dart';
export 'housekeeping/housekeeping.dart';

// External exports
export 'package:flutter_redux/flutter_redux.dart';
export 'package:redux/redux.dart';
export 'package:redux_thunk/redux_thunk.dart';
