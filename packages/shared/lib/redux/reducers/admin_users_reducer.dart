import 'package:shared/redux/states/admin_users_state.dart';
import 'package:shared/redux/actions/admin_users_actions.dart';

AdminUsersState adminUsersReducer(AdminUsersState state, dynamic action) {
  if (action is LoadAdminUsersRequest) {
    return state.copyWith(isLoading: true, error: null, roleFilter: action.roleFilter);
  }
  if (action is LoadAdminUsersSuccess) {
    return state.copyWith(
      isLoading: false,
      items: action.items,
      error: null,
      totalCount: action.totalCount,
    );
  }
  if (action is LoadAdminUsersFailure) {
    return state.copyWith(isLoading: false, error: action.error);
  }

  if (action is UpdateAdminUserRoleRequest) {
    // optimistic update
    final updated = state.items
        .map((u) => u.id == action.userId ? u.copyWith(role: action.role) : u)
        .toList();
    return state.copyWith(items: updated);
  }
  if (action is UpdateAdminUserRoleSuccess) {
    final updated = state.items
        .map((u) => u.id == action.userId ? u.copyWith(role: action.role) : u)
        .toList();
    return state.copyWith(items: updated);
  }
  if (action is UpdateAdminUserRoleFailure) {
    return state.copyWith(error: action.error);
  }

  if (action is UpdateAdminUserStatusRequest) {
    final updated = state.items
        .map((u) => u.id == action.userId
            ? u.copyWith(professionalStatus: action.professionalStatus)
            : u)
        .toList();
    return state.copyWith(items: updated);
  }
  if (action is UpdateAdminUserStatusSuccess) {
    final updated = state.items
        .map((u) => u.id == action.userId
            ? u.copyWith(professionalStatus: action.professionalStatus)
            : u)
        .toList();
    return state.copyWith(items: updated);
  }
  if (action is UpdateAdminUserStatusFailure) {
    return state.copyWith(error: action.error);
  }

  return state;
}
