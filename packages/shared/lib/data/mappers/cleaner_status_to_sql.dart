import 'package:shared/domain/domain.dart';

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
