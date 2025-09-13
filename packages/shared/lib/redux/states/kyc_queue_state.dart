import 'package:equatable/equatable.dart';
import 'package:shared/redux/core/base_state.dart';

class KycItem extends Equatable {
  const KycItem({
    required this.verificationId,
    required this.profileId,
    required this.fullName,
    required this.phoneNumber,
    required this.role,
    required this.documentType,
    required this.fileUrl,
    required this.status,
    required this.uploadDate,
  });

  final String verificationId;
  final String profileId;
  final String? fullName;
  final String? phoneNumber;
  final String role;
  final String documentType;
  final String fileUrl;
  final String status;
  final DateTime uploadDate;

  @override
  List<Object?> get props => [
        verificationId,
        profileId,
        fullName,
        phoneNumber,
        role,
        documentType,
        fileUrl,
        status,
        uploadDate,
      ];
}

class KycQueueState extends BaseState {
  const KycQueueState({
    this.items = const <KycItem>[],
    this.isLoading = false,
    this.error,
    this.selected,
  });

  final List<KycItem> items;
  final bool isLoading;
  final String? error;
  final KycItem? selected;

  KycQueueState copyWith({
    List<KycItem>? items,
    bool? isLoading,
    String? error,
    KycItem? selected,
  }) {
    return KycQueueState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error, selected];

  static const empty = KycQueueState();

  @override
  String get stateType => 'KycQueueState';
}
