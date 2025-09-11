import '../enums/enums.dart';
import 'base_entity.dart';

/// Review entity for service feedback
class Review extends BaseEntity {
  final String bookingId;
  final String reviewerId;
  final String revieweeId;
  final double overallRating;
  final Map<ReviewAspect, double>? aspectRatings;
  final String? comment;
  final List<String> images;
  final bool isVerifiedBooking;

  const Review({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.bookingId,
    required this.reviewerId,
    required this.revieweeId,
    required this.overallRating,
    this.aspectRatings,
    this.comment,
    this.images = const [],
    this.isVerifiedBooking = false,
  });
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
