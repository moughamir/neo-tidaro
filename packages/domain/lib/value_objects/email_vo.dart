import 'base_vo.dart';

/// Email Value Object with validation
class EmailVO extends BaseVO {
  const EmailVO(super.value);
  
  factory EmailVO.create(String email) {
    if (!_isValidEmail(email)) {
      throw ArgumentError('Invalid email format: $email');
    }
    return EmailVO(email);
  }
  
  static bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
