import 'package:shared/domain/domain.dart';

MessageType messageTypeFromSql(String value) {
  switch (value) {
    case 'text':
      return MessageType.text;
    case 'image':
      return MessageType.image;
    case 'file':
      return MessageType.file;
    case 'system':
      return MessageType.system;
    default:
      return MessageType.text;
  }
}
