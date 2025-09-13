import 'package:redux/redux.dart';
import 'package:core/network/supabase_service.dart';

import '../states/app_state.dart';
import '../actions/kyc_actions.dart';
import '../states/kyc_queue_state.dart';

List<Middleware<AppState>> createKycMiddleware(SupabaseService supabase) {
  return [
    TypedMiddleware<AppState, LoadKycQueueRequest>(
      _handleLoadKycQueue(supabase),
    ),
    TypedMiddleware<AppState, VerifyKycRequest>(
      _handleVerifyKyc(supabase),
    ),
  ];
}

Middleware<AppState> _handleLoadKycQueue(SupabaseService supabase) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    try {
      final result = await supabase.getTableData(
        table: 'v_kyc_queue',
        orderBy: 'upload_date',
        ascending: true,
      );

      result.fold(
        (failure) => store.dispatch(LoadKycQueueFailure(failure.message)),
        (rows) {
          final items = rows.map((row) {
            return KycItem(
              verificationId: row['verification_id'] as String,
              profileId: row['profile_id'] as String,
              fullName: row['full_name'] as String?,
              phoneNumber: row['phone_number'] as String?,
              role: row['role'] as String,
              documentType: row['document_type'] as String,
              fileUrl: row['file_url'] as String,
              status: row['status'] as String,
              uploadDate: DateTime.parse(row['upload_date'] as String),
            );
          }).toList();
          store.dispatch(LoadKycQueueSuccess(items));
        },
      );
    } catch (e) {
      store.dispatch(LoadKycQueueFailure(e.toString()));
    }
  };
}

Middleware<AppState> _handleVerifyKyc(SupabaseService supabase) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    final VerifyKycRequest a = action as VerifyKycRequest;
    try {
      final result = await supabase.executeQuery(
        'fn_admin_verify_kyc',
        params: {
          'p_verification_id': a.verificationId,
          'p_decision': a.decision,
          'p_note': a.note,
        },
      );

      result.fold(
        (failure) => store.dispatch(VerifyKycFailure(failure.message)),
        (_) {
          store.dispatch(VerifyKycSuccess(a.verificationId, a.decision));
          // Optionally refresh the queue
          store.dispatch(LoadKycQueueRequest());
        },
      );
    } catch (e) {
      store.dispatch(VerifyKycFailure(e.toString()));
    }
  };
}
