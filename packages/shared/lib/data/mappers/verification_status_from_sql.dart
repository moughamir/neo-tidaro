import 'package:shared/domain/domain.dart';

VerificationStatus verificationStatusFromSql(String value) {
  switch (value) {
    case 'pending':
      return VerificationStatus.pending;
    case 'verified':
      return VerificationStatus.verified;
    case 'rejected':
      return VerificationStatus.rejected;
    case 'expired':
      return VerificationStatus.expired;
    default:
      return VerificationStatus.pending;
  }
}
