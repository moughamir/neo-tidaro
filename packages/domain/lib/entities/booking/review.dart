import '../../enums/enums.dart';
import '../base_entity.dart';

/// Review entity for service feedback
class Review extends BaseEntity {
  /// Creates a new instance of [Review].
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
  /// The ID of the booking this review is for.
  final String bookingId;
  /// The ID of the user who wrote the review.
  final String reviewerId;
  /// The ID of the user being reviewed.
  final String revieweeId;
  /// The overall rating, from 1 to 5.
  final double overallRating;
  /// A map of ratings for specific aspects of the service.
  final Map<PostBookingReviewAspect, double>? aspectRatings;
  /// A written comment for the review.
  final String? comment;
  /// A list of image URLs for the review.
  final List<String> images;
  /// Whether the review is for a verified booking.
  final bool isVerifiedBooking;
}