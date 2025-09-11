import '../enums/enums.dart';

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
    case VerificationStatus.unverified:
      throw UnimplementedError();
  }
}

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
