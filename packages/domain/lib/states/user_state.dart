import '../entities/entities.dart';

class UserState {
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

  factory UserState.initial() => const UserState(isLoading: false);
}
