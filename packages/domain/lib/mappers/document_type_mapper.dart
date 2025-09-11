import 'package:domain/domain.dart';

String documentTypeToSql(DocumentType value) {
  switch (value) {
    case DocumentType.cin:
      return 'cin';
    case DocumentType.cine:
      return 'cine';
    case DocumentType.referenceLetter:
      return 'reference_letter';
    case DocumentType.backgroundCheck:
      return 'background_check';
  }
}

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
