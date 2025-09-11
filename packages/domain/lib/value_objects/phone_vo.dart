import 'base_vo.dart';

/// Phone Value Object with validation
class PhoneVO extends BaseVO {
  const PhoneVO(super.value);
  
  factory PhoneVO.create(String phone) {
    final cleaned = _cleanPhone(phone);
    if (!_isValidPhone(cleaned)) {
      throw ArgumentError('Invalid phone format: $phone');
    }
    return PhoneVO(cleaned);
  }
  
  static String _cleanPhone(String phone) {
    return phone.replaceAll(RegExp(r'[^\d+]'), '');
  }
  
  static bool _isValidPhone(String phone) {
    return RegExp(r'^\+?[\d]{10,15}$').hasMatch(phone);
  }
}
