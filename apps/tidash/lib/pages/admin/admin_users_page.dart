import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

/// Minimal Admin Users management page
/// - Filter by role
/// - List users (name, phone, role, status, created)
/// - Quick actions: change role, change professional status
class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  int _page = 1;
  int _pageSize = 20;
  Timer? _debounce;
  final List<int> _pageSizes = const [10, 20, 50];

  static const roles = <String>[
    'admin',
    'moderator',
    'client_consumer',
    'client_provider',
  ];

  static const statuses = <String>[
    'available',
    'on_job',
    'offline',
    'on_break',
  ];

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Vm>(
      converter: (store) => _Vm.fromStore(store),
      onInit: (store) => store.dispatch(const LoadAdminUsersRequest()),
      builder: (context, vm) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Users'),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    value: vm.roleFilter,
                    hint: const Text('Filter role'),
                    onChanged: (value) {
                      vm.load(
                        role: value,
                        searchQuery: _searchCtrl.text.trim().isEmpty
                            ? null
                            : _searchCtrl.text.trim(),
                        page: 1,
                        pageSize: _pageSize,
                      );
                      setState(() => _page = 1);
                    },
                    items: <DropdownMenuItem<String?>>[
                      const DropdownMenuItem(value: null, child: Text('All')),
                      ...roles.map((r) => DropdownMenuItem(value: r, child: Text(r))),
                    ],
                  ),
                ),
              ),
              // Search field
              SizedBox(
                width: 260,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: _searchCtrl,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: 'Search name or phone',
                      isDense: true,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (val) {
                      vm.load(
                        role: vm.roleFilter,
                        searchQuery: val.trim().isEmpty ? null : val.trim(),
                        page: 1,
                        pageSize: _pageSize,
                      );
                      setState(() => _page = 1);
                    },
                    onChanged: (val) {
                      _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 300), () {
                        vm.load(
                          role: vm.roleFilter,
                          searchQuery:
                              val.trim().isEmpty ? null : val.trim(),
                          page: 1,
                          pageSize: _pageSize,
                        );
                        setState(() => _page = 1);
                      });
                    },
                  ),
                ),
              ),
              // Page size selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _pageSize,
                    onChanged: (val) {
                      if (val == null) return;
                      setState(() {
                        _pageSize = val;
                        _page = 1;
                      });
                      vm.load(
                        role: vm.roleFilter,
                        searchQuery: _searchCtrl.text.trim().isEmpty
                            ? null
                            : _searchCtrl.text.trim(),
                        page: _page,
                        pageSize: _pageSize,
                      );
                    },
                    items: _pageSizes
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text('Page size: $s'),
                            ))
                        .toList(),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Refresh',
                onPressed: () => vm.load(
                  role: vm.roleFilter,
                  searchQuery: _searchCtrl.text.trim().isEmpty
                      ? null
                      : _searchCtrl.text.trim(),
                  page: _page,
                  pageSize: _pageSize,
                ),
                icon: const Icon(Icons.refresh),
              ),
              // Pagination controls
              IconButton(
                tooltip: 'Previous',
                onPressed: _page > 1
                    ? () {
                        setState(() => _page -= 1);
                        vm.load(
                          role: vm.roleFilter,
                          searchQuery: _searchCtrl.text.trim().isEmpty
                              ? null
                              : _searchCtrl.text.trim(),
                          page: _page,
                          pageSize: _pageSize,
                        );
                      }
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  'Page $_page of ${((vm.totalCount + _pageSize - 1) / _pageSize).ceil()}',
                ),
              ),
              IconButton(
                tooltip: 'Next',
                onPressed: (_page * _pageSize) >= vm.totalCount
                    ? null
                    : () {
                  setState(() => _page += 1);
                  vm.load(
                    role: vm.roleFilter,
                    searchQuery: _searchCtrl.text.trim().isEmpty
                        ? null
                        : _searchCtrl.text.trim(),
                    page: _page,
                    pageSize: _pageSize,
                  );
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: vm.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final u = vm.items[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: theme.colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    u.fullName ?? '(no name)',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    u.phoneNumber ?? '-',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Created: ${u.createdAt.toLocal()}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Role dropdown
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Role: '),
                                    DropdownButton<String>(
                                      value: u.role,
                                      onChanged: (val) {
                                        if (val != null && val != u.role) {
                                          vm.updateRole(u.id, val);
                                        }
                                      },
                                      items: roles
                                          .map((r) => DropdownMenuItem(
                                                value: r,
                                                child: Text(r),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Status dropdown
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Status: '),
                                    DropdownButton<String>(
                                      value: u.professionalStatus,
                                      onChanged: (val) {
                                        if (val != null && val != u.professionalStatus) {
                                          vm.updateStatus(u.id, val);
                                        }
                                      },
                                      items: statuses
                                          .map((s) => DropdownMenuItem(
                                                value: s,
                                                child: Text(s),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class _Vm {
  _Vm({
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

  static _Vm fromStore(Store<AppState> store) {
    return _Vm(
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
