// lib/shared/widgets/indicators/loading_indicator.dart

import 'package:fluent_ui/fluent_ui.dart';

/// A standardized loading indicator widget.
///
/// Displays a centered `ProgressRing` with an optional loading message.
class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ProgressRing(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(message!),
          ],
        ],
      ),
    );
  }
}
