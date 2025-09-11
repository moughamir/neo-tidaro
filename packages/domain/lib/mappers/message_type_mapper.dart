import '../enums/enums.dart';

String messageTypeToSql(MessageType value) {
  switch (value) {
    case MessageType.text:
      return 'text';
    case MessageType.image:
      return 'image';
    case MessageType.file:
      return 'file';
    case MessageType.system:
      return 'system';
  }
}

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
