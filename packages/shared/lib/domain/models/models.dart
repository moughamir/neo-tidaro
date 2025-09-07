library shared.models;

import '../entities/entity.dart';

// Export housekeeping-specific models
export 'booking_models.dart';
export 'cleaner_models.dart';
export 'customer_models.dart';
export 'housekeeping_models.dart';
export 'dashboard_models.dart';
export 'profile_models.dart';

class ProfileModel extends ProfileEntity {
  final List<String> skills;
  final List<ServiceModel> offeredServices;
  final List<AvailabilitySlotModel> availabilitySlots;

  const ProfileModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.phoneNumber,
    super.dateOfBirth,
    super.avatarUrl,
    super.role,
    super.isAvailable,
    this.skills = const [],
    this.offeredServices = const [],
    this.availabilitySlots = const [],
  });

  @override
  List<Object?> get props => [
    ...super.props,
    skills,
    offeredServices,
    availabilitySlots,
  ];
}

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.addressLine1,
    required super.city,
    required super.postalCode,
    required super.country,
    super.addressLine2,
    super.state,
    super.isPrimary,
  });
}

class ServiceModel extends ServiceEntity {
  final List<String> providerIds;

  const ServiceModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.name,
    required super.description,
    required super.basePrice,
    required super.currency,
    required super.durationMinutes,
    required super.category,
    super.isActive,
    this.providerIds = const [],
  });

  @override
  List<Object?> get props => [
    ...super.props,
    providerIds,
  ];
}

class BookingModel extends BookingEntity {
  final ProfileModel? client;
  final ProfileModel? provider;
  final ServiceModel? service;
  final AddressModel? address;

  const BookingModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.clientId,
    required super.serviceId,
    required super.status,
    required super.scheduledDate,
    required super.durationMinutes,
    required super.totalPrice,
    super.providerId,
    super.addressId,
    super.specialInstructions,
    super.cancellationReason,
    this.client,
    this.provider,
    this.service,
    this.address,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    client,
    provider,
    service,
    address,
  ];
}

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.bookingId,
    required super.amount,
    required super.currency,
    required super.status,
    required super.paymentMethod,
    super.transactionId,
    super.refundAmount,
  });
}

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.messageType,
    super.bookingId,
    super.mediaUrl,
    super.isRead,
    super.isModerated,
    super.moderatedBy,
    super.moderatedAt,
  });
}

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.bookingId,
    required super.reviewerId,
    required super.revieweeId,
    required super.rating,
    super.comment,
    super.isVerifiedBooking,
  });
}

class VerificationDocumentModel extends VerificationDocumentEntity {
  const VerificationDocumentModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.profileId,
    required super.documentType,
    required super.documentUrl,
    required super.verificationStatus,
    super.verifiedBy,
    super.verifiedAt,
    super.rejectionReason,
  });
}

class AvailabilitySlotModel extends AvailabilitySlotEntity {
  const AvailabilitySlotModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.providerId,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    required super.isAvailable,
  });
}

class BlockedPeriodModel extends BlockedPeriodEntity {
  const BlockedPeriodModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.profileId,
    required super.startTime,
    required super.endTime,
    super.reason,
  });
}

class AuditLogModel extends AuditLogEntity {
  const AuditLogModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.action,
    super.profileId,
    required super.resourceType,
    required super.resourceId,
    super.previousValues,
    super.newValues,
    super.ipAddress,
    super.userAgent,
  });
}
