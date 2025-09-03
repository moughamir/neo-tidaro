// lib/shared/widgets/dialogs/generic_dialog.dart

import 'package:fluent_ui/fluent_ui.dart';

/// A utility function to show a standardized content dialog.
///
/// Simplifies the process of showing a dialog with a consistent look and feel.
Future<void> showGenericDialog(BuildContext context, {
  required String title,
  required Widget content,
  List<Widget>? actions,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(title),
      content: content,
      actions: actions,
    ),
  );
}
