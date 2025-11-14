import 'package:shared/shared.dart';

class AdminUsersViewModel {
  AdminUsersViewModel({
    required this.isLoading,
    required this.items,
    required this.totalCount,
    required this.roleFilter,
    required this.load,
    required this.updateRole,
    required this.updateStatus,
  });

  final bool isLoading;
  final List<AdminUser> items;
  final int totalCount;
  final String? roleFilter;
  final void Function({String? role, String? searchQuery, int page, int pageSize}) load;
  final void Function(String userId, String role) updateRole;
  final void Function(String userId, String status) updateStatus;

  static AdminUsersViewModel fromStore(Store<AppState> store) {
    return AdminUsersViewModel(
      isLoading: store.state.adminUsersState.isLoading,
      items: store.state.adminUsersState.items,
      totalCount: store.state.adminUsersState.totalCount,
      roleFilter: store.state.adminUsersState.roleFilter,
      load: ({String? role, String? searchQuery, int page = 1, int pageSize = 20}) =>
          store.dispatch(LoadAdminUsersRequest(
            roleFilter: role,
            searchQuery: searchQuery,
            page: page,
            pageSize: pageSize,
          )),
      updateRole: (id, role) =>
          store.dispatch(UpdateAdminUserRoleRequest(id, role)),
      updateStatus: (id, status) => store.dispatch(
        UpdateAdminUserStatusRequest(id, status),
      ),
    );
  }
}
