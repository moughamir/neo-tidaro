library shared.enums;

// Re-export canonical enums defined in domain/models to avoid duplication
export '../models/booking_models.dart' show BookingStatus, ServiceCategory;
export '../models/profile_models.dart' show UserRole;
export '../models/cleaner_models.dart' show CleanerStatus;

// Keep enums that are only defined at the enum layer
enum PaymentStatus { pending, processing, completed, failed, refunded }

enum VerificationStatus { pending, verified, rejected, expired }

enum MessageType { text, image, file, system }

enum DocumentType { cin, cine, referenceLetter, backgroundCheck }
