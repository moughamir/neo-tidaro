import 'package:core/network/supabase_service.dart';
import 'package:redux/redux.dart';
import 'package:postgrest/postgrest.dart';

import 'package:shared/redux/states/app_state.dart';
import 'package:shared/redux/actions/admin_users_actions.dart';

List<Middleware<AppState>> createAdminUsersMiddleware(
  SupabaseServiceInterface supabase,
) {
  return [
    TypedMiddleware<AppState, LoadAdminUsersRequest>(
      _handleLoad(supabase).call,
    ).call,
    TypedMiddleware<AppState, UpdateAdminUserRoleRequest>(
      _handleUpdateRole(supabase).call,
    ).call,
    TypedMiddleware<AppState, UpdateAdminUserStatusRequest>(
      _handleUpdateStatus(supabase).call,
    ).call,
  ];
}

void Function(Store<AppState>, LoadAdminUsersRequest, NextDispatcher)
_handleLoad(SupabaseServiceInterface supabase) {
  return (store, action, next) {
    next(action);

    final int page = action.page <= 0 ? 1 : action.page;
    final int pageSize = action.pageSize <= 0 ? 20 : action.pageSize;
    final int from = (page - 1) * pageSize;
    final int to = from + pageSize - 1;

    var query = supabase.client.from('profiles').select();

    // Role filter
    if (action.roleFilter != null && action.roleFilter!.isNotEmpty) {
      query = query.eq('role', action.roleFilter!);
    }

    // Search filter (full_name OR phone_number)
    if (action.searchQuery != null && action.searchQuery!.trim().isNotEmpty) {
      final term = action.searchQuery!.trim();
      final like = '%$term%';
      query = query.or('full_name.ilike.$like,phone_number.ilike.$like');
    }

    // Build rows (paged)
    final rowsBuilder = query
        .order('created_at', ascending: false)
        .range(from, to);

    // Build count query with same filters (id-only, no range)
    var countQuery = supabase.client.from('profiles').select('id');
    if (action.roleFilter != null && action.roleFilter!.isNotEmpty) {
      countQuery = countQuery.eq('role', action.roleFilter!);
    }
    if (action.searchQuery != null && action.searchQuery!.trim().isNotEmpty) {
      final term = action.searchQuery!.trim();
      final like = '%$term%';
      countQuery = countQuery.or(
        'full_name.ilike.$like,phone_number.ilike.$like',
      );
    }

    supabase
        .safeAsyncCall<List<Map<String, dynamic>>>(
          () async {
            final PostgrestList response = await rowsBuilder.select();
            return List<Map<String, dynamic>>.from(response);
          },
          context: 'Loading admin users (rows)',
          tag: 'AdminUsers',
        )
        .then((rowsEither) {
          rowsEither.fold(
            (failure) => store.dispatch(LoadAdminUsersFailure(failure.message)),
            (rows) {
              // After rows, get total count
              supabase
                  .safeAsyncCall<int>(
                    () async {
                      final PostgrestList response = await countQuery.select();
                      return response.length;
                    },
                    context: 'Loading admin users (count)',
                    tag: 'AdminUsers',
                  )
                  .then((countEither) {
                    final totalCount = countEither.fold(
                      (_) => rows.length,
                      (c) => c,
                    );
                    final users = rows.map((row) {
                      return AdminUser(
                        id: row['id'] as String,
                        fullName: row['full_name'] as String?,
                        phoneNumber: row['phone_number'] as String?,
                        role: row['role'] as String,
                        professionalStatus:
                            (row['professional_status'] as String?) ??
                            'offline',
                        createdAt: DateTime.parse(row['created_at'] as String),
                      );
                    }).toList();
                    store.dispatch(LoadAdminUsersSuccess(users, totalCount));
                  });
            },
          );
        });
  };
}

void Function(Store<AppState>, UpdateAdminUserRoleRequest, NextDispatcher)
_handleUpdateRole(SupabaseServiceInterface supabase) {
  return (store, action, next) {
    next(action);
    supabase
        .updateTableData(
          table: 'profiles',
          data: {'role': action.role},
          where: {'id': action.userId},
        )
        .then((res) {
          res.fold(
            (failure) =>
                store.dispatch(UpdateAdminUserRoleFailure(failure.message)),
            (_) {
              store.dispatch(
                UpdateAdminUserRoleSuccess(action.userId, action.role),
              );
              store.dispatch(const LoadAdminUsersRequest());
            },
          );
        });
  };
}

void Function(Store<AppState>, UpdateAdminUserStatusRequest, NextDispatcher)
_handleUpdateStatus(SupabaseServiceInterface supabase) {
  return (store, action, next) {
    next(action);
    supabase
        .updateTableData(
          table: 'profiles',
          data: {'professional_status': action.professionalStatus},
          where: {'id': action.userId},
        )
        .then((res) {
          res.fold(
            (failure) =>
                store.dispatch(UpdateAdminUserStatusFailure(failure.message)),
            (_) {
              store.dispatch(
                UpdateAdminUserStatusSuccess(
                  action.userId,
                  action.professionalStatus,
                ),
              );
              store.dispatch(const LoadAdminUsersRequest());
            },
          );
        });
  };
}
