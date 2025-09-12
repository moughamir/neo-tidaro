import 'package:domain/entities/user/user.dart' show User;
import 'package:domain/enums/kyc.dart';
import 'package:shared/redux/core/core.dart';
import 'package:shared/redux/states/auth_state.dart';

/// Authentication selectors following functional programming patterns
class AuthSelectors {
  const AuthSelectors._();

  /// Select if user is authenticated
  static final isAuthenticated = SelectorUtils.create<AuthState, bool>(
    (state) => state.isAuthenticated,
  );

  /// Select if authentication is loading
  static final isLoading = SelectorUtils.isLoading<AuthState, User>();

  /// Select current user
  static final currentUser = SelectorUtils.dataOrNull<AuthState, User>();

  /// Select authentication error
  static final error = SelectorUtils.errorOrNull<AuthState, User>();

  /// Select if there's an authentication error
  static final hasError = SelectorUtils.create<AuthState, bool>(
    (state) => state.hasError,
  );

  /// Select auth token
  static final authToken = SelectorUtils.create<AuthState, String?>(
    (state) => state.authToken.toNullable(),
  );

  /// Select if user has valid token
  static final hasValidToken = SelectorUtils.create<AuthState, bool>(
    (state) => state.authToken.isSome() && state.isAuthenticated,
  );

  /// Select user email (if available)
  static final userEmail = SelectorUtils.create<AuthState, String?>(
    (state) => state.dataOrNull?.email,
  );

  /// Select user name (if available)
  static final userName = SelectorUtils.create<AuthState, String?>(
    (state) => state.dataOrNull?.profile?.fullName,
  );

  /// Select if user email is verified
  static final isEmailVerified = SelectorUtils.create<AuthState, bool>(
    (state) =>
        state.dataOrNull?.verificationStatus == VerificationStatus.verified,
  );

  /// Memoized selector for user profile data
  static final userProfile =
      SelectorUtils.createMemoized<AuthState, Map<String, dynamic>?>((state) {
        final user = state.dataOrNull;
        if (user == null) return null;

        return {
          'id': user.id,
          'email': user.email,
          'name': user.profile?.fullName,
          'avatarUrl': user.profile?.avatarUrl,
          'phoneNumber': user.phoneNumber,
          'emailVerified':
              user.verificationStatus == VerificationStatus.verified,
        };
      });
}
