import '../../enums/enums.dart';
import '../base_entity.dart';

/// Review entity for service feedback
class Review extends BaseEntity {
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
  final String bookingId;
  final String reviewerId;
  final String revieweeId;
  final double overallRating;
  final Map<PostBookingReviewAspect, double>? aspectRatings;
  final String? comment;
  final List<String> images;
  final bool isVerifiedBooking;
}
