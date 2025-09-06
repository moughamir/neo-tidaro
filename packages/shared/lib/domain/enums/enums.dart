library shared.enums;

enum UserRole { admin, moderator, clientConsumer, clientProvider }

enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled,
  disputed,
}

enum PaymentStatus { pending, processing, completed, failed, refunded }

enum VerificationStatus { pending, verified, rejected, expired }

enum MessageType { text, image, file, system }

enum DocumentType { cin, cine, referenceLetter, backgroundCheck }
