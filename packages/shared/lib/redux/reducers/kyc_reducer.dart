import 'package:shared/redux/actions/kyc_actions.dart';
import 'package:shared/redux/states/kyc_queue_state.dart';

/// KYC Queue reducer
KycQueueState kycReducer(KycQueueState state, dynamic action) {
  if (action is LoadKycQueueRequest) {
    return state.copyWith(isLoading: true, error: null);
  }
  if (action is LoadKycQueueSuccess) {
    return state.copyWith(items: action.items, isLoading: false, error: null);
  }
  if (action is LoadKycQueueFailure) {
    return state.copyWith(isLoading: false, error: action.error);
  }
  if (action is SelectKycItem) {
    return state.copyWith(selected: action.item);
  }
  if (action is VerifyKycRequest) {
    return state.copyWith(isLoading: true, error: null);
  }
  if (action is VerifyKycSuccess) {
    // Optimistic removal of the verified/rejected item from queue
    final updated = state.items.where((e) => e.verificationId != action.verificationId).toList();
    return state.copyWith(items: updated, isLoading: false);
  }
  if (action is VerifyKycFailure) {
    return state.copyWith(isLoading: false, error: action.error);
  }
  return state;
}
