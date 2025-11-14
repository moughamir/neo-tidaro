import 'package:shared/shared.dart';

class KycReviewViewModel {
  KycReviewViewModel({
    required this.items,
    required this.isLoading,
    required this.selected,
    required this.select,
    required this.verify,
  });

  final List<KycItem> items;
  final bool isLoading;
  final KycItem? selected;
  final void Function(KycItem?) select;
  final void Function(String verificationId, String decision, String? note) verify;

  static KycReviewViewModel fromStore(Store<AppState> store) {
    final s = store.state.kycQueueState;
    return KycReviewViewModel(
      items: s.items,
      isLoading: s.isLoading,
      selected: s.selected,
      select: (item) => store.dispatch(SelectKycItem(item)),
      verify: (id, decision, note) => store.dispatch(
        VerifyKycRequest(verificationId: id, decision: decision, note: note),
      ),
    );
  }
}
