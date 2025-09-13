import 'package:domain/domain.dart';
import 'package:shared/redux/core/core.dart';

class UserState extends BaseState {
  final User? user;
  final UserProfile? profile;
  final List<Address> addresses;
  final KycDocument? kycDocument;
  final bool isLoading;
  final String? error;

  const UserState({
    this.user,
    this.profile,
    this.addresses = const [],
    this.kycDocument,
    required this.isLoading,
    this.error,
  });

  factory UserState.initial() => const UserState(isLoading: true);

  @override
  List<Object?> get props => [
    user,
    profile,
    addresses,
    kycDocument,
    isLoading,
    error,
  ];

  @override
  String get stateType => 'userState';
}
