/// The status of a message.
enum MessageStatus {
  /// The message has been sent.
  sent,
  /// The message has been delivered.
  delivered,
  /// The message has been read.
  read,
  /// The message has been deleted.
  deleted,
  /// The message has been edited.
  edited
}

/// The type of a message.
enum MessageType {
  /// A text message.
  text,
  /// An image message.
  image,
  /// A file message.
  file,
  /// A system message.
  system
}

/// The role of a user in a chat.
enum ChatRole {
  /// A participant in the chat.
  participant,
  /// A moderator of the chat.
  moderator
}

/// The moderation action taken on a user or content.
enum ModerationAction {
  /// No action taken.
  none,
  /// A warning was issued.
  warning,
  /// The user was suspended.
  suspension,
  /// The user was banned.
  ban,
  /// The content was removed.
  contentRemoval
}

/// The flag for content moderation.
enum ContentFlag {
  /// The content is inappropriate.
  inappropriate,
  /// The content is spam.
  spam,
  /// The content is fraudulent.
  fraud,
  /// The content is harassment.
  harassment,
  /// The content is violent.
  violence,
  /// The content is something else.
  other
}

/// The type of a notification.
enum NotificationType {
  /// A notification related to a booking.
  booking,
  /// A notification related to a payment.
  payment,
  /// A notification related to a message.
  message,
  /// A notification related to a review.
  review,
  /// A system notification.
  system,
  /// A promotional notification.
  promotion,
  /// A reminder notification.
  reminder,
}