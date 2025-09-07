/// Redux barrel file following Clean Architecture and DRY principles
library redux;

// Core Redux dependencies
export 'package:flutter_redux/flutter_redux.dart';
export 'package:redux/redux.dart';
export 'package:redux_thunk/redux_thunk.dart';

// Core Redux architecture
export 'core/core.dart';

// Application state
export 'app_state.dart';

// Type-organized exports
export 'actions/actions.dart';
export 'states/states.dart';
export 'reducers/reducers.dart';
export 'selectors/selectors.dart';
export 'middleware/middleware.dart';

// Store configuration
export 'store/store.dart';

// Example scaffolds
export 'examples/examples.dart';
