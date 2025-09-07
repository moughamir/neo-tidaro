import 'package:shared/domain/domain.dart';

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
