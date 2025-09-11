import '../enums/enums.dart';

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

String cleanerStatusToSql(CleanerStatus value) {
  switch (value) {
    case CleanerStatus.available:
      return 'available';
    case CleanerStatus.onJob:
      return 'on_job';
    case CleanerStatus.offline:
      return 'offline';
    case CleanerStatus.onBreak:
      return 'on_break';
  }
}
