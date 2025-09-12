import '../enums/enums.dart';

ProfessionalActivityStatus professionalActivityStatusFromSql(String value) {
  switch (value) {
    case 'available':
      return ProfessionalActivityStatus.available;
    case 'on_job':
      return ProfessionalActivityStatus.onJob;
    case 'offline':
      return ProfessionalActivityStatus.offline;
    case 'on_break':
      return ProfessionalActivityStatus.onBreak;
    default:
      return ProfessionalActivityStatus.offline;
  }
}

String professionalActivityStatusToSql(ProfessionalActivityStatus value) {
  switch (value) {
    case ProfessionalActivityStatus.available:
      return 'available';
    case ProfessionalActivityStatus.onJob:
      return 'on_job';
    case ProfessionalActivityStatus.offline:
      return 'offline';
    case ProfessionalActivityStatus.onBreak:
      return 'on_break';
  }
}
