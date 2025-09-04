/// UI Actions for managing application-wide UI state
abstract class UiAction {}

class SetLoadingAction extends UiAction {
  final bool isLoading;
  SetLoadingAction(this.isLoading);
}

class IncrementCounterAction extends UiAction {}

class DecrementCounterAction extends UiAction {}

class ResetCounterAction extends UiAction {}

class SetCounterAction extends UiAction {
  final int value;
  SetCounterAction(this.value);
}

class ShowErrorAction extends UiAction {
  final String error;
  ShowErrorAction(this.error);
}

class ClearErrorAction extends UiAction {}

class ShowSuccessMessageAction extends UiAction {
  final String message;
  ShowSuccessMessageAction(this.message);
}

class ClearSuccessMessageAction extends UiAction {}

class ClearAllMessagesAction extends UiAction {}
