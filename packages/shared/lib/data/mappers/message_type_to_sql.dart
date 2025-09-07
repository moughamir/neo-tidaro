import 'package:shared/domain/domain.dart';

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
