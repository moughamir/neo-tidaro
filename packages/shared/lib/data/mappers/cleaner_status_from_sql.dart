import 'package:shared/domain/domain.dart';

CleanerStatus cleanerStatusFromSql(String value) {
  switch (value) {
    case 'available':
      return CleanerStatus.available;
    case 'on_job':
      return CleanerStatus.onJob;
    case 'offline':
      return CleanerStatus.offline;
    case 'on_break':
      return CleanerStatus.onBreak;
    default:
      return CleanerStatus.offline;
  }
}
