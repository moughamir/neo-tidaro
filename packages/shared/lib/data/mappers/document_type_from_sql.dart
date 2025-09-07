import 'package:shared/domain/domain.dart';

DocumentType documentTypeFromSql(String value) {
  switch (value) {
    case 'cin':
      return DocumentType.cin;
    case 'cine':
      return DocumentType.cine;
    case 'reference_letter':
      return DocumentType.referenceLetter;
    case 'background_check':
      return DocumentType.backgroundCheck;
    default:
      return DocumentType.cin;
  }
}
