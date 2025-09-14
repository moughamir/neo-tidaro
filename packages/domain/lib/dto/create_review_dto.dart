import '../enums/review_aspect.dart';

/// Data transfer object for creating a review.
class CreateReviewDto {
  /// Creates a new instance of [CreateReviewDto].
  const CreateReviewDto({
    required this.bookingId,
    required this.reviewerId,
    required this.revieweeId,
    required this.overallRating,
    required this.aspectRatings,
    this.comment,
    this.images,
  });
  /// The ID of the booking being reviewed.
  final String bookingId;
  /// The ID of the user who wrote the review.
  final String reviewerId;
  /// The ID of the user being reviewed.
  final String revieweeId;
  /// The overall rating, from 1 to 5.
  final double overallRating;
  /// A map of ratings for specific aspects of the service.
  final Map<PostBookingReviewAspect, double> aspectRatings;
  /// A written comment for the review.
  final String? comment;
  /// A list of image URLs for the review.
  final List<String>? images;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'booking_id': bookingId,
    'reviewer_id': reviewerId,
    'reviewee_id': revieweeId,
    'overall_rating': overallRating,
    'aspect_ratings': aspectRatings.map(
      (key, value) => MapEntry(key.name, value),
    ),
    'comment': comment,
    'images': images,
  };
}