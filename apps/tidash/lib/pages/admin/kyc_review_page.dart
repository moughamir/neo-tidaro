import 'package:flutter/material.dart';
import 'package:shared/redux/redux.dart';

/// KYC Review Page for TiDash backoffice
class KycReviewPage extends StatelessWidget {
  const KycReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Vm>(
      converter: (store) => _Vm.fromStore(store),
      onInit: (store) => store.dispatch(LoadKycQueueRequest()),
      builder: (context, vm) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(title: const Text('KYC Review')),
          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: vm.items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = vm.items[index];
                          final isSelected = vm.selected?.verificationId == item.verificationId;
                          return ListTile(
                            selected: isSelected,
                            leading: CircleAvatar(child: Text(item.fullName?.substring(0, 1) ?? '?')),
                            title: Text(item.fullName ?? item.profileId),
                            subtitle: Text('${item.documentType} • ${item.uploadDate.toLocal()}'),
                            trailing: Text(item.status, style: theme.textTheme.bodySmall),
                            onTap: () => vm.select(item),
                          );
                        },
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: vm.selected == null
                            ? const Center(child: Text('Select a KYC entry to review'))
                            : _DetailPanel(
                                item: vm.selected!,
                                onDecision: (decision, note) => vm.verify(vm.selected!.verificationId, decision, note),
                              ),
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }
}

class _Vm {
  _Vm({
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

  static _Vm fromStore(Store<AppState> store) {
    final s = store.state.kycQueueState;
    return _Vm(
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

class _DetailPanel extends StatefulWidget {
  const _DetailPanel({required this.item, required this.onDecision});
  final KycItem item;
  final void Function(String decision, String? note) onDecision;

  @override
  State<_DetailPanel> createState() => _DetailPanelState();
}

class _DetailPanelState extends State<_DetailPanel> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.fullName ?? item.profileId, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text('Document: ${item.documentType}')
            ,
        const SizedBox(height: 8),
        Text('Status: ${item.status}')
            ,
        const SizedBox(height: 12),
        TextField(
          controller: _noteController,
          decoration: const InputDecoration(
            labelText: 'Review note (optional)',
            border: OutlineInputBorder(),
          ),
          minLines: 2,
          maxLines: 4,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => widget.onDecision('verified', _noteController.text.isEmpty ? null : _noteController.text),
              icon: const Icon(Icons.check_circle),
              label: const Text('Approve'),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () => widget.onDecision('rejected', _noteController.text.isEmpty ? null : _noteController.text),
              icon: const Icon(Icons.cancel),
              label: const Text('Reject'),
            ),
          ],
        )
      ],
    );
  }
}
