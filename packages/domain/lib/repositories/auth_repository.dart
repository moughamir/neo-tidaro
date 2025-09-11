import '../dto/auth_dto.dart';
import '../entities/entities.dart';
import '../enums/enums.dart';
import 'base_repository.dart';

/// Domain-pure authentication repository interface
abstract class AuthRepository {
  // Pure domain auth state
  Stream<AuthenticationStateType> get authStateChanges;
  User? get currentUser;
  AuthSession? get currentSession;

  Future<RepositoryResult<User>> signUp(SignUpDto dto);
  Future<RepositoryResult<User>> signIn(SignInDto dto);
  Future<RepositoryResult<User>> signInWithOAuth(OAuthSignInDto dto);
  Future<void> signOut();
  Future<RepositoryResult<AuthSession>> refreshSession();
  Future<RepositoryResult<User>> updateUser(Map<String, dynamic> attributes);
  Future<void> resetPassword(String email);
  Future<void> verifyOtp({
    required String token,
    required OtpVerificationType type,
  });
  Future<void> resendOtp({
    required OtpVerificationType type,
    required String email,
  });
}
