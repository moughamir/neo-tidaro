// lib/shared/widgets/layout/page_scaffold.dart

import 'package:fluent_ui/fluent_ui.dart';

/// A standardized page scaffold widget.
///
/// This widget provides a consistent layout structure for pages across the app,
/// including a page header and standardized padding.
class PageScaffold extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final EdgeInsets padding;

  const PageScaffold({
    super.key,
    this.header,
    required this.body,
    this.padding = const EdgeInsets.all(24.0),
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: header,
      content: Padding(
        padding: padding,
        child: body,
      ),
    );
  }
}
