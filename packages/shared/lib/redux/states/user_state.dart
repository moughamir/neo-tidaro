import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:shared/redux/core/core.dart';

class UserState extends BaseState {
  const UserState({
    this.user,
    this.profile,
    this.addresses = const [],
    this.kycDocument,
    required this.isLoading,
    this.error,
  });

  factory UserState.initial() => const UserState(isLoading: true);
  final User? user;
  final Profile? profile;
  final List<Address> addresses;
  final KycDocument? kycDocument;
  final bool isLoading;
  final String? error;

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
