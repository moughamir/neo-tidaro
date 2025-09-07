import 'package:fpdart/fpdart.dart';
import '../../core/base_action.dart';

class IncrementAction extends BaseAction {
  const IncrementAction();
  static const typeValue = 'COUNTER/INCREMENT';
  @override
  String get type => typeValue;
}

class DecrementAction extends BaseAction {
  const DecrementAction();
  static const typeValue = 'COUNTER/DECREMENT';
  @override
  String get type => typeValue;
}

class IncrementAsyncAction extends BaseAsyncAction<int> {
  const IncrementAsyncAction({this.by = 1, this.delayMs = 500});
  final int by;
  final int delayMs;

  static const baseType = 'COUNTER/INCREMENT_ASYNC';
  @override
  String get type => baseType;

  @override
  Future<Either<Exception, int>> execute() async {
    try {
      await Future<void>.delayed(Duration(milliseconds: delayMs));
      return right(by);
    } catch (e) {
      return left(Exception(e.toString()));
    }
  }
}
