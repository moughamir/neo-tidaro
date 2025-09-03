// lib/shared/widgets/layout/responsive_layout.dart

import 'package:fluent_ui/fluent_ui.dart';

const double kMobileBreakpoint = 640.0;
const double kTabletBreakpoint = 1007.0;

/// A layout widget that adapts its child to the screen size.
///
/// Builds a different widget for mobile, tablet, and desktop layouts
/// based on the defined breakpoints.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    this.tabletBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < kMobileBreakpoint) {
          return mobileBody;
        } else if (constraints.maxWidth < kTabletBreakpoint) {
          return tabletBody ?? desktopBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
