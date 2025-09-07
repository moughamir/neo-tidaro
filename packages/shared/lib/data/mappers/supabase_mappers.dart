// ignore_for_file: constant_identifier_names

import 'package:shared/domain/enums/enums.dart' as core;
import 'package:shared/domain/models/profile_models.dart' as models;
import 'package:shared/domain/models/booking_models.dart' as booking_models;
import 'package:shared/domain/models/cleaner_models.dart' as cleaner_models;

/// Enum mappers between Supabase (snake_case strings) and Domain (camelCase enums)

// -------------------- UserRole --------------------
// Note: models.Profile currently defines its own UserRole enum.
// Map SQL directly to models.UserRole to avoid type mismatches.
models.UserRole userRoleFromSql(String value) {
  switch (value) {
    case 'admin':
      return models.UserRole.admin;
    case 'moderator':
      return models.UserRole.moderator;
    case 'client_consumer':
      return models.UserRole.clientConsumer;
    case 'client_provider':
      return models.UserRole.clientProvider;
    default:
      return models.UserRole.clientConsumer;
  }
}

String userRoleToSql(models.UserRole value) {
  switch (value) {
    case models.UserRole.admin:
      return 'admin';
    case models.UserRole.moderator:
      return 'moderator';
    case models.UserRole.clientConsumer:
      return 'client_consumer';
    case models.UserRole.clientProvider:
      return 'client_provider';
  }
}

// -------------------- BookingStatus --------------------
// Note: DB supports: pending, confirmed, assigned, in_progress, completed, cancelled, rescheduled
// Domain duplicates exist; prefer booking_models.BookingStatus for persistence mapping.
booking_models.BookingStatus bookingStatusFromSql(String value) {
  switch (value) {
    case 'pending':
      return booking_models.BookingStatus.pending;
    case 'confirmed':
      return booking_models.BookingStatus.confirmed;
    case 'assigned':
      return booking_models.BookingStatus.assigned;
    case 'in_progress':
      return booking_models.BookingStatus.inProgress;
    case 'completed':
      return booking_models.BookingStatus.completed;
    case 'cancelled':
      return booking_models.BookingStatus.cancelled;
    case 'rescheduled':
      return booking_models.BookingStatus.rescheduled;
    default:
      // Fallback to pending
      return booking_models.BookingStatus.pending;
  }
}

String bookingStatusToSql(booking_models.BookingStatus value) {
  switch (value) {
    case booking_models.BookingStatus.pending:
      return 'pending';
    case booking_models.BookingStatus.confirmed:
      return 'confirmed';
    case booking_models.BookingStatus.assigned:
      return 'assigned';
    case booking_models.BookingStatus.inProgress:
      return 'in_progress';
    case booking_models.BookingStatus.completed:
      return 'completed';
    case booking_models.BookingStatus.cancelled:
      return 'cancelled';
    case booking_models.BookingStatus.rescheduled:
      return 'rescheduled';
    case booking_models.BookingStatus.noShow:
      // Not in DB – map to cancelled by policy
      return 'cancelled';
  }
}

// -------------------- ServiceCategory --------------------
booking_models.ServiceCategory serviceCategoryFromSql(String value) {
  switch (value) {
    case 'standard_cleaning':
      return booking_models.ServiceCategory.standardCleaning;
    case 'regular_cleaning':
      return booking_models.ServiceCategory.regularCleaning;
    case 'deep_cleaning':
      return booking_models.ServiceCategory.deepCleaning;
    case 'move_in_out':
      return booking_models.ServiceCategory.moveInOut;
    case 'post_construction':
      return booking_models.ServiceCategory.postConstruction;
    case 'commercial':
      return booking_models.ServiceCategory.commercial;
    case 'residential':
      return booking_models.ServiceCategory.residential;
    case 'specialized':
      return booking_models.ServiceCategory.specialized;
    default:
      return booking_models.ServiceCategory.standardCleaning;
  }
}

String serviceCategoryToSql(booking_models.ServiceCategory value) {
  switch (value) {
    case booking_models.ServiceCategory.standardCleaning:
      return 'standard_cleaning';
    case booking_models.ServiceCategory.regularCleaning:
      return 'regular_cleaning';
    case booking_models.ServiceCategory.deepCleaning:
      return 'deep_cleaning';
    case booking_models.ServiceCategory.moveInOut:
      return 'move_in_out';
    case booking_models.ServiceCategory.postConstruction:
      return 'post_construction';
    case booking_models.ServiceCategory.commercial:
      return 'commercial';
    case booking_models.ServiceCategory.residential:
      return 'residential';
    case booking_models.ServiceCategory.specialized:
      return 'specialized';
  }
}

// -------------------- PaymentStatus --------------------
// DB: pending, paid, failed, refunded
// Domain (core.PaymentStatus): pending, processing, completed, failed, refunded
core.PaymentStatus paymentStatusFromSql(String value) {
  switch (value) {
    case 'pending':
      return core.PaymentStatus.pending;
    case 'paid':
      return core.PaymentStatus.completed; // map DB 'paid' to domain 'completed'
    case 'failed':
      return core.PaymentStatus.failed;
    case 'refunded':
      return core.PaymentStatus.refunded;
    default:
      return core.PaymentStatus.pending;
  }
}

String paymentStatusToSql(core.PaymentStatus value) {
  switch (value) {
    case core.PaymentStatus.pending:
      return 'pending';
    case core.PaymentStatus.processing:
      return 'pending'; // no DB equivalent; treat as pending/in-flight
    case core.PaymentStatus.completed:
      return 'paid';
    case core.PaymentStatus.failed:
      return 'failed';
    case core.PaymentStatus.refunded:
      return 'refunded';
  }
}

// -------------------- CleanerStatus --------------------
cleaner_models.CleanerStatus cleanerStatusFromSql(String value) {
  switch (value) {
    case 'available':
      return cleaner_models.CleanerStatus.available;
    case 'on_job':
      return cleaner_models.CleanerStatus.onJob;
    case 'offline':
      return cleaner_models.CleanerStatus.offline;
    case 'on_break':
      return cleaner_models.CleanerStatus.onBreak;
    default:
      return cleaner_models.CleanerStatus.offline;
  }
}

String cleanerStatusToSql(cleaner_models.CleanerStatus value) {
  switch (value) {
    case cleaner_models.CleanerStatus.available:
      return 'available';
    case cleaner_models.CleanerStatus.onJob:
      return 'on_job';
    case cleaner_models.CleanerStatus.offline:
      return 'offline';
    case cleaner_models.CleanerStatus.onBreak:
      return 'on_break';
  }
}

// -------------------- MessageType --------------------
core.MessageType messageTypeFromSql(String value) {
  switch (value) {
    case 'text':
      return core.MessageType.text;
    case 'image':
      return core.MessageType.image;
    case 'file':
      return core.MessageType.file;
    case 'system':
      return core.MessageType.system;
    default:
      return core.MessageType.text;
  }
}

String messageTypeToSql(core.MessageType value) {
  switch (value) {
    case core.MessageType.text:
      return 'text';
    case core.MessageType.image:
      return 'image';
    case core.MessageType.file:
      return 'file';
    case core.MessageType.system:
      return 'system';
  }
}

// -------------------- DocumentType --------------------
core.DocumentType documentTypeFromSql(String value) {
  switch (value) {
    case 'cin':
      return core.DocumentType.cin;
    case 'cine':
      return core.DocumentType.cine;
    case 'reference_letter':
      return core.DocumentType.referenceLetter;
    case 'background_check':
      return core.DocumentType.backgroundCheck;
    default:
      return core.DocumentType.cin;
  }
}

String documentTypeToSql(core.DocumentType value) {
  switch (value) {
    case core.DocumentType.cin:
      return 'cin';
    case core.DocumentType.cine:
      return 'cine';
    case core.DocumentType.referenceLetter:
      return 'reference_letter';
    case core.DocumentType.backgroundCheck:
      return 'background_check';
  }
}

// -------------------- VerificationStatus --------------------
core.VerificationStatus verificationStatusFromSql(String value) {
  switch (value) {
    case 'pending':
      return core.VerificationStatus.pending;
    case 'verified':
      return core.VerificationStatus.verified;
    case 'rejected':
      return core.VerificationStatus.rejected;
    case 'expired':
      return core.VerificationStatus.expired;
    default:
      return core.VerificationStatus.pending;
  }
}

String verificationStatusToSql(core.VerificationStatus value) {
  switch (value) {
    case core.VerificationStatus.pending:
      return 'pending';
    case core.VerificationStatus.verified:
      return 'verified';
    case core.VerificationStatus.rejected:
      return 'rejected';
    case core.VerificationStatus.expired:
      return 'expired';
  }
}

// ===================================================================
// Profile DTO for Supabase
// ===================================================================

class SupabaseProfileDto {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final String? phoneNumber;
  final models.UserRole role;
  final cleaner_models.CleanerStatus? cleanerStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SupabaseProfileDto({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.phoneNumber,
    required this.role,
    this.cleanerStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory SupabaseProfileDto.fromMap(Map<String, dynamic> map) {
    return SupabaseProfileDto(
      id: map['id'] as String,
      fullName: map['full_name'] as String? ?? '',
      avatarUrl: map['avatar_url'] as String?,
      phoneNumber: map['phone_number'] as String?,
      role: userRoleFromSql(map['role'] as String),
      cleanerStatus: map['cleaner_status'] != null
          ? cleanerStatusFromSql(map['cleaner_status'] as String)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'phone_number': phoneNumber,
      'role': userRoleToSql(role),
      'cleaner_status': cleanerStatus != null
          ? cleanerStatusToSql(cleanerStatus!)
          : null,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }

  // Mapping to domain Profile model (models/Profile)
  models.Profile toDomain() {
    return models.Profile(
      id: id,
      fullName: fullName,
      avatarUrl: avatarUrl,
      phoneNumber: phoneNumber,
      role: role,
      cleanerStatus: cleanerStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static SupabaseProfileDto fromDomain(models.Profile profile) {
    return SupabaseProfileDto(
      id: profile.id,
      fullName: profile.fullName,
      avatarUrl: profile.avatarUrl,
      phoneNumber: profile.phoneNumber,
      role: profile.role,
      cleanerStatus: profile.cleanerStatus,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );
  }
}
