enum MessageStatus { sent, delivered, read, deleted, edited }

enum MessageType { text, image, file, system }

enum ChatRole { participant, moderator }

enum ModerationAction { none, warning, suspension, ban, contentRemoval }

enum ContentFlag { inappropriate, spam, fraud, harassment, violence, other }

enum NotificationType {
  booking,
  payment,
  message,
  review,
  system,
  promotion,
  reminder,
}
