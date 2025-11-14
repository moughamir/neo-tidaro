import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import 'kyc_review_view_model.dart';

class KycReviewPage extends StatelessWidget {
  const KycReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, KycReviewViewModel>(
      converter: (store) => KycReviewViewModel.fromStore(store),
      onInit: (store) => store.dispatch(LoadKycQueueRequest()),
      builder: (context, vm) {
        return PageScaffold(
          header: const Header(title: 'KYC Review'),
          body: vm.isLoading
              ? const LoadingIndicator(message: 'Loading KYC queue...')
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: KycItemList(vm: vm),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      flex: 3,
                      child: KycDetailPanel(vm: vm),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class KycItemList extends StatelessWidget {
  const KycItemList({super.key, required this.vm});

  final KycReviewViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: vm.items.length,
      itemBuilder: (context, index) {
        final item = vm.items[index];
        return KycItemCard(
          item: item,
          isSelected: vm.selected?.verificationId == item.verificationId,
          onTap: () => vm.select(item),
        );
      },
    );
  }
}

class KycItemCard extends StatelessWidget {
  const KycItemCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final KycItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: isSelected ? theme.colorScheme.primary.withOpacity(0.1) : null,
      child: ListTile(
        leading: CircleAvatar(child: Text(item.fullName?.substring(0, 1) ?? '?')),
        title: Text(item.fullName ?? item.profileId),
        subtitle: Text('${item.documentType} • ${item.uploadDate.toLocal()}'),
        trailing: Text(item.status, style: theme.textTheme.bodySmall),
        onTap: onTap,
      ),
    );
  }
}

class KycDetailPanel extends StatelessWidget {
  const KycDetailPanel({super.key, required this.vm});

  final KycReviewViewModel vm;

  @override
  Widget build(BuildContext context) {
    if (vm.selected == null) {
      return const Center(child: Text('Select a KYC entry to review'));
    }
    return KycDetailContent(
      item: vm.selected!,
      onDecision: (decision, note) =>
          vm.verify(vm.selected!.verificationId, decision, note),
    );
  }
}

class KycDetailContent extends StatefulWidget {
  const KycDetailContent({
    super.key,
    required this.item,
    required this.onDecision,
  });

  final KycItem item;
  final void Function(String decision, String? note) onDecision;

  @override
  State<KycDetailContent> createState() => _KycDetailContentState();
}

class _KycDetailContentState extends State<KycDetailContent> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.fullName ?? item.profileId, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text('Document: ${item.documentType}'),
          const SizedBox(height: 8),
          Text('Status: ${item.status}'),
          const SizedBox(height: 16),
          // TODO: Display document image
          const Expanded(
            child: Center(
              child: Text('Document image viewer placeholder'),
            ),
          ),
          const SizedBox(height: 16),
          InputField(
            controller: _noteController,
            labelText: 'Review note (optional)',
            minLines: 2,
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Button(
                label: 'Approve',
                onPressed: () =>
                    widget.onDecision('verified', _noteController.text.isEmpty ? null : _noteController.text),
                type: ButtonType.primary,
                icon: Icons.check_circle,
              ),
              const SizedBox(width: 16),
              Button(
                label: 'Reject',
                onPressed: () =>
                    widget.onDecision('rejected', _noteController.text.isEmpty ? null : _noteController.text),
                type: ButtonType.danger,
                icon: Icons.cancel,
              ),
            ],
          )
        ],
      ),
    );
  }
}
