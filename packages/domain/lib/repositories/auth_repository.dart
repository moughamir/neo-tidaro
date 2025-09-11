import 'package:domain/dto/auth_dto.dart';
import 'package:domain/entities/authentication.dart';
import 'package:domain/entities/user.dart';
import 'package:domain/enums/enums.dart';

/// Domain-pure authentication repository interface
abstract class AuthRepository {
  // Pure domain auth state
  Stream<AuthenticationStateType> get authStateChanges;
  User? get currentUser;
  AuthSession? get currentSession;

  Future<AuthResult<User>> signUp(SignUpDto dto);
  Future<AuthResult<User>> signIn(SignInDto dto);
  Future<AuthResult<User>> signInWithOAuth(OAuthSignInDto dto);
  Future<void> signOut();
  Future<AuthResult<AuthSession>> refreshSession();
  Future<AuthResult<User>> updateUser(Map<String, dynamic> attributes);
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
