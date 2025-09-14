import 'package:equatable/equatable.dart';
import 'package:shared/redux/states/kyc_queue_state.dart';

// Load KYC Queue
class LoadKycQueueRequest extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadKycQueueSuccess extends Equatable {
  LoadKycQueueSuccess(this.items);
  final List<KycItem> items;
  @override
  List<Object?> get props => [items];
}

class LoadKycQueueFailure extends Equatable {
  LoadKycQueueFailure(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}

// Select item
class SelectKycItem extends Equatable {
  SelectKycItem(this.item);
  final KycItem? item;
  @override
  List<Object?> get props => [item];
}

// Verify / Reject
class VerifyKycRequest extends Equatable {
  VerifyKycRequest({
    required this.verificationId,
    required this.decision,
    this.note,
  });
  final String verificationId;
  final String decision; // 'verified' | 'rejected'
  final String? note;
  @override
  List<Object?> get props => [verificationId, decision, note];
}

class VerifyKycSuccess extends Equatable {
  VerifyKycSuccess(this.verificationId, this.decision);
  final String verificationId;
  final String decision;
  @override
  List<Object?> get props => [verificationId, decision];
}

class VerifyKycFailure extends Equatable {
  VerifyKycFailure(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
