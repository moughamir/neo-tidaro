import '../dto/pagination_dto.dart';
import '../entities/entities.dart';
import 'base_repository.dart';

/// Repository interface for chat messages.
///
/// This is a domain-only contract. Implementations belong to infrastructure
/// (e.g., Shared/Infra) and must not introduce framework dependencies here.
abstract class MessageRepository extends BaseRepository<Message> {
  /// Returns all messages for a specific [bookingId].
  Future<RepositoryResult<List<Message>>> findByBookingId(
    String bookingId, {
    PaginationDto? pagination,
  });

  /// Sends a new [message].
  Future<RepositoryResult<Message>> sendMessage(Message message);

  /// Marks a message as read by its [id].
  Future<RepositoryResult<bool>> markAsRead(String id);
}
