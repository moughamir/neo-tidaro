import 'package:fpdart/fpdart.dart';
import 'base_state.dart';

/// Base selector interface following SOLID principles
/// All Redux selectors must implement this interface
abstract class BaseSelector<S extends BaseState, T> {
  const BaseSelector();

  /// Select data from state
  T select(S state);

  /// Compose with another selector
  BaseSelector<S, R> compose<R>(BaseSelector<T, R> other) {
    return _ComposedSelector(this, other);
  }

  /// Map the selected value
  BaseSelector<S, R> map<R>(R Function(T value) mapper) {
    return _MappedSelector(this, mapper);
  }

  /// Filter the selected value with Option
  BaseSelector<S, Option<T>> filter(bool Function(T value) predicate) {
    return _FilteredSelector(this, predicate);
  }
}

/// Memoized selector for performance optimization
abstract class MemoizedSelector<S extends BaseState, T> extends BaseSelector<S, T> {
  MemoizedSelector() : _cache = {};

  final Map<S, T> _cache;

  @override
  T select(S state) {
    if (_cache.containsKey(state)) {
      return _cache[state]!;
    }

    final result = compute(state);
    _cache[state] = result;
    
    // Keep cache size reasonable
    if (_cache.length > 100) {
      _cache.clear();
    }
    
    return result;
  }

  /// Compute the selector value (to be implemented by subclasses)
  T compute(S state);

  /// Clear the cache
  void clearCache() => _cache.clear();
}

/// Async selector for operations that can fail
abstract class AsyncSelector<S extends BaseAsyncState<D>, D, T> 
    extends BaseSelector<S, Option<T>> {
  const AsyncSelector();

  @override
  Option<T> select(S state) {
    return state.data.flatMap((data) => selectFromData(data));
  }

  /// Select from the data when available
  Option<T> selectFromData(D data);
}

/// Selector utilities following DRY principles
class SelectorUtils {
  const SelectorUtils._();

  /// Create a simple selector
  static BaseSelector<S, T> create<S extends BaseState, T>(
    T Function(S state) selector,
  ) {
    return _FunctionSelector(selector);
  }

  /// Create a memoized selector
  static MemoizedSelector<S, T> createMemoized<S extends BaseState, T>(
    T Function(S state) selector,
  ) {
    return _FunctionMemoizedSelector(selector);
  }

  /// Combine multiple selectors
  static BaseSelector<S, List<T>> combine<S extends BaseState, T>(
    List<BaseSelector<S, T>> selectors,
  ) {
    return _CombinedSelector(selectors);
  }

  /// Create a selector that returns data or null for async states
  static BaseSelector<S, T?> dataOrNull<S extends BaseAsyncState<T>, T>() {
    return create<S, T?>((state) => state.dataOrNull);
  }

  /// Create a selector that returns error or null for async states
  static BaseSelector<S, Exception?> errorOrNull<S extends BaseAsyncState<T>, T>() {
    return create<S, Exception?>((state) => state.errorOrNull);
  }

  /// Create a selector that returns loading state for async states
  static BaseSelector<S, bool> isLoading<S extends BaseAsyncState<T>, T>() {
    return create<S, bool>((state) => state.isLoading);
  }
}

/// Internal implementations

class _FunctionSelector<S extends BaseState, T> extends BaseSelector<S, T> {
  const _FunctionSelector(this.selector);

  final T Function(S state) selector;

  @override
  T select(S state) => selector(state);
}

class _FunctionMemoizedSelector<S extends BaseState, T> extends MemoizedSelector<S, T> {
  _FunctionMemoizedSelector(this.selector);

  final T Function(S state) selector;

  @override
  T compute(S state) => selector(state);
}

class _ComposedSelector<S extends BaseState, T, R> extends BaseSelector<S, R> {
  const _ComposedSelector(this.first, this.second);

  final BaseSelector<S, T> first;
  final BaseSelector<T, R> second;

  @override
  R select(S state) => second.select(first.select(state));
}

class _MappedSelector<S extends BaseState, T, R> extends BaseSelector<S, R> {
  const _MappedSelector(this.selector, this.mapper);

  final BaseSelector<S, T> selector;
  final R Function(T value) mapper;

  @override
  R select(S state) => mapper(selector.select(state));
}

class _FilteredSelector<S extends BaseState, T> extends BaseSelector<S, Option<T>> {
  const _FilteredSelector(this.selector, this.predicate);

  final BaseSelector<S, T> selector;
  final bool Function(T value) predicate;

  @override
  Option<T> select(S state) {
    final value = selector.select(state);
    return predicate(value) ? some(value) : none();
  }
}

class _CombinedSelector<S extends BaseState, T> extends BaseSelector<S, List<T>> {
  const _CombinedSelector(this.selectors);

  final List<BaseSelector<S, T>> selectors;

  @override
  List<T> select(S state) {
    return selectors.map((selector) => selector.select(state)).toList();
  }
}
