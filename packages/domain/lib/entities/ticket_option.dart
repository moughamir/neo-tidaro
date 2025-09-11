import '../enums/enums.dart';
import 'base_entity.dart';

class TicketOption extends BaseEntity {
  final TicketOptionType type;
  final String name;
  final String? color;

  TicketOption({
    required super.id,
    required this.type,
    required this.name,
    this.color,
  });
}
