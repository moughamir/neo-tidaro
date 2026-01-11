---
title: README
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# Redux Examples & Scaffolds

This directory provides minimal, production-aligned Redux scaffolds to standardize patterns across apps and features.

## Counter Example
Located under `packages/shared/lib/redux/examples/counter/`.

Components:
- `counter_state.dart` – Immutable state (extends `BaseState`) with `copyWith`
- `counter_actions.dart` – Sync and async actions (`BaseAction`, `BaseAsyncAction`)
- `counter_reducer.dart` – Reducer using `ReducerUtils.createReducer`
- `counter_middleware.dart` – Async side-effects using `AsyncMiddleware`
- `counter_selectors.dart` – Typed selectors via `BaseSelector`
- `store.dart` – `Store<CounterState>` factory with logging middleware
- `counter_example_widget.dart` – Minimal Flutter UI to demonstrate wiring

## How to use in an app

1) Import the examples barrel via `shared` package’s Redux export:
```dart
import 'package:shared/redux.dart';
```
This already exports `examples/examples.dart` which contains the counter example.

2) Create a store (example):
```dart
final store = createCounterStore();
```

3) Provide the store at the top level:
```dart
return StoreProvider<CounterState>(
  store: store,
  child: MaterialApp(
    home: const CounterExamplePage(),
  ),
);
```

4) Dispatch actions from UI:
```dart
StoreProvider.of<CounterState>(context).dispatch(const IncrementAction());
StoreProvider.of<CounterState>(context).dispatch(const IncrementAsyncAction());
```

## Pattern Guidance
- Keep feature state, actions, reducer, selectors, and middleware under a dedicated folder
- Use `BaseAction`, `BaseReducer`, `BaseMiddleware`, and `BaseSelector` from `packages/shared/lib/redux/core/` to ensure consistency
- Prefer `ReducerUtils.createReducer` for mapping action types to handlers
- For async flows:
  - Dispatch a `RequestAction` (or use `ActionCreators.request`) to set loading
  - Execute async work in middleware via `BaseAsyncAction.execute()`
  - Let middleware dispatch `SuccessAction`/`FailureAction` accordingly

## Next steps
- Replicate this scaffold for new features (e.g., `booking`, `staff`, etc.)
- Keep business/domain models in `packages/shared/domain/` and import them in Redux layers