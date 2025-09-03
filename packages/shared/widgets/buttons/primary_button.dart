// lib/shared/widgets/buttons/primary_button.dart

import 'package:fluent_ui/fluent_ui.dart';

/// A standardized primary action button.
///
/// This is a wrapper around Fluent UI's `FilledButton` to ensure
/// consistent styling for primary actions throughout the app.
class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }
}
