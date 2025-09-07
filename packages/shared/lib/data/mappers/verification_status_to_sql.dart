import 'package:shared/domain/domain.dart';

String verificationStatusToSql(VerificationStatus value) {
  switch (value) {
    case VerificationStatus.pending:
      return 'pending';
    case VerificationStatus.verified:
      return 'verified';
    case VerificationStatus.rejected:
      return 'rejected';
    case VerificationStatus.expired:
      return 'expired';
  }
}
