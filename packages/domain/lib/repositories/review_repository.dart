import '../dto/pagination_dto.dart';
import '../entities/entities.dart';
import '../enums/enums.dart';
import 'base_repository.dart';

/// Generic review repository for any reviewable entity
abstract class ReviewRepository<T extends BaseEntity>
    extends BaseRepository<Review> {
  Future<Review> createReview({
    required String reviewerId,
    required String targetId,
    required double rating,
    String? comment,
    List<ReviewAspectRating>? aspectRatings,
  });

  Future<List<Review>> getReviewsForTarget(
    String targetId, {
    PaginationDto? pagination,
    PreBookingSortBy? sortBy,
  });

  Future<List<Review>> getReviewsByReviewer(
    String reviewerId, {
    PaginationDto? pagination,
  });

  Future<ReviewSummary> getReviewSummary(String targetId);

  Future<bool> updateReview(Review review);
  Future<bool> deleteReview(String reviewId);

  Future<bool> reportReview(String reviewId, String reason);
  Future<bool> moderateReview(String reviewId, ModerationAction action);

  Stream<List<Review>> watchReviewsForTarget(String targetId);
  Future<Review> findByBookingId(String bookingId);
  Future<Review> submit(Review review);
  Future<void> verify(String id);
}

/// Review aspect rating for detailed feedback
class ReviewAspectRating {
  const ReviewAspectRating({required this.aspect, required this.rating});
  final PostBookingReviewAspect aspect;
  final double rating;
}

/// Review summary statistics
class ReviewSummary {
  const ReviewSummary({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
    required this.aspectAverages,
  });
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution;
  final Map<PostBookingReviewAspect, double> aspectAverages;
}
