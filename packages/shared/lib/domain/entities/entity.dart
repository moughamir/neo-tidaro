library shared.entities;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show TimeOfDay;

import '../enums/enums.dart';

/// Base class for all domain entities
///
/// Provides unique ID handling and equality comparison through Equatable
abstract class Entity extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Entity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id];
}

abstract class ProfileEntity extends Entity {
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final UserRole role;
  final bool isAvailable;

  const ProfileEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.avatarUrl,
    this.role = UserRole.clientConsumer,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    email,
    firstName,
    lastName,
    phoneNumber,
    dateOfBirth,
    avatarUrl,
    role,
    isAvailable,
  ];
}

abstract class AddressEntity extends Entity {
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String? state;
  final String postalCode;
  final String country;
  final bool isPrimary;

  const AddressEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.addressLine1,
    required this.city,
    required this.postalCode,
    required this.country,
    this.addressLine2,
    this.state,
    this.isPrimary = false,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    isPrimary,
  ];
}

abstract class ServiceEntity extends Entity {
  final String name;
  final String description;
  final double basePrice;
  final String currency;
  final int durationMinutes;
  final String category;
  final bool isActive;

  const ServiceEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.currency,
    required this.durationMinutes,
    required this.category,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    name,
    description,
    basePrice,
    currency,
    durationMinutes,
    category,
    isActive,
  ];
}

abstract class BookingEntity extends Entity {
  final String clientId;
  final String? providerId;
  final String serviceId;
  final String? addressId;
  final BookingStatus status;
  final DateTime scheduledDate;
  final int durationMinutes;
  final double totalPrice;
  final String? specialInstructions;
  final String? cancellationReason;

  const BookingEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.clientId,
    required this.serviceId,
    required this.status,
    required this.scheduledDate,
    required this.durationMinutes,
    required this.totalPrice,
    this.providerId,
    this.addressId,
    this.specialInstructions,
    this.cancellationReason,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    clientId,
    providerId,
    serviceId,
    addressId,
    status,
    scheduledDate,
    durationMinutes,
    totalPrice,
    specialInstructions,
    cancellationReason,
  ];
}

abstract class PaymentEntity extends Entity {
  final String bookingId;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final String paymentMethod;
  final String? transactionId;
  final double? refundAmount;

  const PaymentEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.bookingId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    this.transactionId,
    this.refundAmount,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    bookingId,
    amount,
    currency,
    status,
    paymentMethod,
    transactionId,
    refundAmount,
  ];
}

abstract class MessageEntity extends Entity {
  final String senderId;
  final String receiverId;
  final String? bookingId;
  final String content;
  final MessageType messageType;
  final String? mediaUrl;
  final bool isRead;
  final bool isModerated;
  final String? moderatedBy;
  final DateTime? moderatedAt;

  const MessageEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.messageType,
    this.bookingId,
    this.mediaUrl,
    this.isRead = false,
    this.isModerated = false,
    this.moderatedBy,
    this.moderatedAt,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    senderId,
    receiverId,
    bookingId,
    content,
    messageType,
    mediaUrl,
    isRead,
    isModerated,
    moderatedBy,
    moderatedAt,
  ];
}

abstract class ReviewEntity extends Entity {
  final String bookingId;
  final String reviewerId;
  final String revieweeId;
  final int rating;
  final String? comment;
  final bool isVerifiedBooking;

  const ReviewEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.bookingId,
    required this.reviewerId,
    required this.revieweeId,
    required this.rating,
    this.comment,
    this.isVerifiedBooking = false,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    bookingId,
    reviewerId,
    revieweeId,
    rating,
    comment,
    isVerifiedBooking,
  ];
}

abstract class VerificationDocumentEntity extends Entity {
  final String profileId;
  final DocumentType documentType;
  final String documentUrl;
  final VerificationStatus verificationStatus;
  final String? verifiedBy;
  final DateTime? verifiedAt;
  final String? rejectionReason;

  const VerificationDocumentEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.profileId,
    required this.documentType,
    required this.documentUrl,
    required this.verificationStatus,
    this.verifiedBy,
    this.verifiedAt,
    this.rejectionReason,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    profileId,
    documentType,
    documentUrl,
    verificationStatus,
    verifiedBy,
    verifiedAt,
    rejectionReason,
  ];
}

abstract class AvailabilitySlotEntity extends Entity {
  final String providerId;
  final int dayOfWeek;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isAvailable;

  const AvailabilitySlotEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.providerId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    providerId,
    dayOfWeek,
    startTime,
    endTime,
    isAvailable,
  ];
}

abstract class BlockedPeriodEntity extends Entity {
  final String profileId;
  final DateTime startTime;
  final DateTime endTime;
  final String? reason;

  const BlockedPeriodEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.profileId,
    required this.startTime,
    required this.endTime,
    this.reason,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    profileId,
    startTime,
    endTime,
    reason,
  ];
}

abstract class AuditLogEntity extends Entity {
  final String action;
  final String? profileId;
  final String resourceType;
  final String resourceId;
  final Map<String, dynamic>? previousValues;
  final Map<String, dynamic>? newValues;
  final String? ipAddress;
  final String? userAgent;

  const AuditLogEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.action,
    this.profileId,
    required this.resourceType,
    required this.resourceId,
    this.previousValues,
    this.newValues,
    this.ipAddress,
    this.userAgent,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    action,
    profileId,
    resourceType,
    resourceId,
    previousValues,
    newValues,
    ipAddress,
    userAgent,
  ];
}
