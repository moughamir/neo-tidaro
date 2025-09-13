import '../enums/review_aspect.dart';

class CreateReviewDto {
  const CreateReviewDto({
    required this.bookingId,
    required this.reviewerId,
    required this.revieweeId,
    required this.overallRating,
    required this.aspectRatings,
    this.comment,
    this.images,
  });
  final String bookingId;
  final String reviewerId;
  final String revieweeId;
  final double overallRating;
  final Map<PostBookingReviewAspect, double> aspectRatings;
  final String? comment;
  final List<String>? images;

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
