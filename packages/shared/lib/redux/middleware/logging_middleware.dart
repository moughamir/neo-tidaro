import 'package:redux/redux.dart';

/// Creates simple logging middleware for Redux store
List<Middleware<T>> createLoggingMiddleware<T>({void Function(String message)? logger}) {
  return [
    (Store<T> store, dynamic action, NextDispatcher next) {
      final String actionMsg = 'Action: ${action.runtimeType}';
      if (logger != null) {
        logger(actionMsg);
      } else {
        // ignore: avoid_print
        print(actionMsg);
      }
      next(action);
      final String stateMsg = 'State: ${store.state}';
      if (logger != null) {
        logger(stateMsg);
      } else {
        // ignore: avoid_print
        print(stateMsg);
      }
    },
  ];
}
