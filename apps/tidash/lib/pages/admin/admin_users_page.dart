import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import 'admin_users_view_model.dart';

class AdminUsersPage extends StatelessWidget {
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AdminUsersViewModel>(
      converter: (store) => AdminUsersViewModel.fromStore(store),
      onInit: (store) => store.dispatch(const LoadAdminUsersRequest()),
      builder: (context, vm) {
        return PageScaffold(
          header: const Header(title: 'Users'),
          body: Column(
            children: [
              AdminUsersFilter(vm: vm),
              Expanded(
                child: vm.isLoading
                    ? const LoadingIndicator(message: 'Loading users...')
                    : UserList(vm: vm),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AdminUsersFilter extends StatefulWidget {
  const AdminUsersFilter({super.key, required this.vm});

  final AdminUsersViewModel vm;

  @override
  State<AdminUsersFilter> createState() => _AdminUsersFilterState();
}

class _AdminUsersFilterState extends State<AdminUsersFilter> {
  final TextEditingController _searchCtrl = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: InputField(
              controller: _searchCtrl,
              hintText: 'Search by name or phone',
              prefixIcon: Icons.search,
              onChanged: (value) {
                _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 300), () {
                  widget.vm.load(
                    role: widget.vm.roleFilter,
                    searchQuery: value.trim().isEmpty ? null : value.trim(),
                    page: 1,
                    pageSize: 20,
                  );
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Select<String?>(
            value: widget.vm.roleFilter,
            onChanged: (value) {
              widget.vm.load(
                role: value,
                searchQuery: _searchCtrl.text.trim().isEmpty ? null : _searchCtrl.text.trim(),
                page: 1,
                pageSize: 20,
              );
            },
            items: [
              const SelectOption(value: null, label: 'All Roles'),
              ...AdminUsersViewModel.fromStore(StoreProvider.of<AppState>(context))
                  .items
                  .map((user) => user.role)
                  .toSet()
                  .map((role) => SelectOption(value: role, label: role))
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList({super.key, required this.vm});

  final AdminUsersViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.items.length,
      itemBuilder: (context, index) {
        final user = vm.items[index];
        return UserCard(user: user, vm: vm);
      },
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user, required this.vm});

  final AdminUser user;
  final AdminUsersViewModel vm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(user.fullName?.substring(0, 1) ?? '-'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.fullName ?? '(no name)', style: theme.textTheme.titleMedium),
                  Text(user.phoneNumber ?? '-', style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Select<String>(
                  value: user.role,
                  onChanged: (value) {
                    if (value != null) {
                      vm.updateRole(user.id, value);
                    }
                  },
                  items: AdminUsersViewModel.fromStore(StoreProvider.of<AppState>(context))
                      .items
                      .map((user) => user.role)
                      .toSet()
                      .map((role) => SelectOption(value: role, label: role))
                      .toList(),
                ),
                const SizedBox(height: 8),
                Select<String>(
                  value: user.professionalStatus,
                  onChanged: (value) {
                    if (value != null) {
                      vm.updateStatus(user.id, value);
                    }
                  },
                  items: AdminUsersViewModel.fromStore(StoreProvider.of<AppState>(context))
                      .items
                      .map((user) => user.professionalStatus)
                      .toSet()
                      .map((status) => SelectOption(value: status, label: status))
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
