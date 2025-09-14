import '../core/base_state.dart';
import '../actions/admin_users_actions.dart';

class AdminUsersState extends BaseState {
  const AdminUsersState({
    this.isLoading = false,
    this.items = const <AdminUser>[],
    this.error,
    this.roleFilter,
    this.totalCount = 0,
  });

  final bool isLoading;
  final List<AdminUser> items;
  final String? error;
  final String? roleFilter;
  final int totalCount;

  AdminUsersState copyWith({
    bool? isLoading,
    List<AdminUser>? items,
    String? error,
    String? roleFilter,
    int? totalCount,
  }) => AdminUsersState(
        isLoading: isLoading ?? this.isLoading,
        items: items ?? this.items,
        error: error,
        roleFilter: roleFilter ?? this.roleFilter,
        totalCount: totalCount ?? this.totalCount,
      );

  static const empty = AdminUsersState();

  @override
  List<Object?> get props => [isLoading, items, error, roleFilter, totalCount];

  @override
  String get stateType => 'AdminUsersState';
}
