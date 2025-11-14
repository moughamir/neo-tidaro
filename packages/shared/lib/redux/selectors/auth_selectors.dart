import 'package:core/core.dart' hide AuthState;
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

  /// Memoized selector for user profile data
  static final userProfile =
      SelectorUtils.createMemoized<AuthState, Map<String, dynamic>?>((state) {
        final user = state.dataOrNull;
        if (user == null) return null;

        return {
          'id': user.id,
          'email': user.email,
          'name': user.userMetadata?['full_name'],
          'phone': user.userMetadata?['phone'],
          'emailVerified': user.emailConfirmedAt != null,
        };
      });
}
