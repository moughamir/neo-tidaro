import 'package:shared/domain/domain.dart';

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
