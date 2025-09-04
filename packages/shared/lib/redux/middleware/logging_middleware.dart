import 'package:redux/redux.dart';

/// Creates simple logging middleware for Redux store
List<Middleware<T>> createLoggingMiddleware<T>() {
  return [
    (Store<T> store, dynamic action, NextDispatcher next) {
      print('Action: ${action.runtimeType}');
      next(action);
      print('State: ${store.state}');
    },
  ];
}
