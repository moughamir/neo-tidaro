import 'package:shared/domain/domain.dart';

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
