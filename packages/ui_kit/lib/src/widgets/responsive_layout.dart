import 'package:flutter/material.dart';

/// Breakpoints for responsive design
enum ScreenSize {
  /// < 600px
  small,

  /// 600px - 960px
  medium,

  /// 960px - 1280px
  large,

  /// > 1280px
  extraLarge,
}

/// A responsive layout component that adapts to different screen sizes
///
/// This widget provides a convenient way to build responsive UIs by specifying
/// different layouts for different screen sizes.
class ResponsiveLayout extends StatelessWidget {
  /// Builder for small screens (< 600px)
  final WidgetBuilder? smallBuilder;

  /// Builder for medium screens (600px - 960px)
  final WidgetBuilder? mediumBuilder;

  /// Builder for large screens (960px - 1280px)
  final WidgetBuilder? largeBuilder;

  /// Builder for extra large screens (> 1280px)
  final WidgetBuilder? extraLargeBuilder;

  /// Default builder if no specific builder is provided for current screen size
  final WidgetBuilder defaultBuilder;

  const ResponsiveLayout({
    super.key,
    this.smallBuilder,
    this.mediumBuilder,
    this.largeBuilder,
    this.extraLargeBuilder,
    required this.defaultBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = _getScreenSize(constraints.maxWidth);

        switch (screenSize) {
          case ScreenSize.small:
            return smallBuilder?.call(context) ?? defaultBuilder(context);
          case ScreenSize.medium:
            return mediumBuilder?.call(context) ?? defaultBuilder(context);
          case ScreenSize.large:
            return largeBuilder?.call(context) ?? defaultBuilder(context);
          case ScreenSize.extraLarge:
            return extraLargeBuilder?.call(context) ?? defaultBuilder(context);
        }
      },
    );
  }

  /// Determines the screen size based on width
  static ScreenSize _getScreenSize(double width) {
    if (width < 600) {
      return ScreenSize.small;
    } else if (width < 960) {
      return ScreenSize.medium;
    } else if (width < 1280) {
      return ScreenSize.large;
    } else {
      return ScreenSize.extraLarge;
    }
  }

  /// Gets the current screen size from MediaQuery
  static ScreenSize getScreenSizeFromContext(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return _getScreenSize(width);
  }

  /// Returns true if the current screen size is considered mobile
  static bool isMobile(BuildContext context) {
    final size = getScreenSizeFromContext(context);
    return size == ScreenSize.small;
  }

  /// Returns true if the current screen size is considered tablet
  static bool isTablet(BuildContext context) {
    final size = getScreenSizeFromContext(context);
    return size == ScreenSize.medium;
  }

  /// Returns true if the current screen size is considered desktop
  static bool isDesktop(BuildContext context) {
    final size = getScreenSizeFromContext(context);
    return size == ScreenSize.large || size == ScreenSize.extraLarge;
  }
}
