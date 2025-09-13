import 'package:flutter/material.dart';

/// A responsive grid view that adapts to different screen sizes
///
/// This widget automatically adjusts the number of columns based on the available width,
/// making it perfect for item lists that need to adapt to different device sizes.
class ResponsiveGridView extends StatelessWidget {

  const ResponsiveGridView({
    super.key,
    required this.children,
    this.minItemWidth = 300,
    this.horizontalSpacing = 16,
    this.verticalSpacing = 16,
    this.padding,
    this.mainAxisScroll = true,
  });
  /// List of items to display in the grid
  final List<Widget> children;
  
  /// Minimum width for each item
  final double minItemWidth;
  
  /// Spacing between items horizontally
  final double horizontalSpacing;
  
  /// Spacing between items vertically
  final double verticalSpacing;
  
  /// Padding around the grid
  final EdgeInsetsGeometry? padding;
  
  /// Whether to scroll in the main axis direction
  final bool mainAxisScroll;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate how many items can fit in a row
        final width = constraints.maxWidth;
        final crossAxisCount = (width / (minItemWidth + horizontalSpacing)).floor();
        final actualCrossAxisCount = crossAxisCount > 0 ? crossAxisCount : 1;
        
        return GridView.builder(
          padding: padding,
          shrinkWrap: !mainAxisScroll,
          physics: mainAxisScroll
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: actualCrossAxisCount,
            childAspectRatio: 1.0,
            crossAxisSpacing: horizontalSpacing,
            mainAxisSpacing: verticalSpacing,
            mainAxisExtent: null, // Allow items to size themselves vertically
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}
