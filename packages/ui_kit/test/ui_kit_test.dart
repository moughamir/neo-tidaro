import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/src/widgets/glassy_card.dart';
import 'package:ui_kit/src/widgets/neomorphic_button.dart';
import 'test_utils/test_theme.dart';

void main() {
  // Global setup for all tests
  setUp(() {});

  // Helper function to create a wrapped testing environment
  Widget createTestWidget(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  group('AppTheme Tests', () {
    test('Light theme should have correct properties', () {
      // Use our test theme which doesn't depend on Google Fonts
      final theme = TestAppTheme.lightTheme;

      // Verify theme properties match the expected values
      expect(theme.colorScheme.brightness, equals(Brightness.light));
      expect(theme.colorScheme.primary, equals(const Color(0xFF4A6572)));
      expect(theme.colorScheme.secondary, equals(const Color(0xFFF9AA33)));
      expect(theme.colorScheme.surface, equals(const Color(0xFFFAFAFA)));
    });

    test('Dark theme should have correct properties', () {
      // Use our test theme which doesn't depend on Google Fonts
      final theme = TestAppTheme.darkTheme;

      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.brightness, equals(Brightness.dark));
      expect(theme.colorScheme.primary, equals(const Color(0xFF4A6572)));
      expect(theme.colorScheme.secondary, equals(const Color(0xFFF9AA33)));
      expect(theme.colorScheme.surface, equals(const Color(0xFF121212)));
    });

    test('Text theme should have correct text sizes', () {
      // Get text theme from test theme
      final TextTheme textTheme = TestAppTheme.lightTheme.textTheme;

      // Only test size properties
      expect(textTheme.bodyLarge?.fontSize, equals(16.0));
      expect(textTheme.bodyMedium?.fontSize, equals(14.0));
      expect(textTheme.bodySmall?.fontSize, equals(12.0));
      expect(textTheme.displayLarge?.fontSize, equals(32.0));
      expect(textTheme.displayMedium?.fontSize, equals(24.0));

      // Test weights
      expect(textTheme.bodyLarge?.fontWeight, equals(FontWeight.normal));
      expect(textTheme.displayLarge?.fontWeight, equals(FontWeight.bold));
    });
  });

  group('NeomorphicButton Tests', () {
    testWidgets('NeomorphicButton should render correctly', (
      WidgetTester tester,
    ) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        createTestWidget(
          Center(
            child: NeomorphicButton(
              onPressed: () {
                buttonPressed = true;
              },
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      // Verify button exists
      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(NeomorphicButton), findsOneWidget);

      // Verify default properties
      final buttonFinder = find.byType(AnimatedContainer);
      expect(buttonFinder, findsOneWidget);

      final AnimatedContainer container = tester.widget(buttonFinder);
      final BoxDecoration decoration = container.decoration as BoxDecoration;

      expect(decoration.borderRadius, equals(BorderRadius.circular(12.0)));
      expect(decoration.color, equals(const Color(0xFFF9FAFB)));
      expect(decoration.boxShadow?.length, equals(2));

      // Tap the button and verify callback is executed
      await tester.tap(find.byType(NeomorphicButton));
      await tester.pumpAndSettle();
      expect(buttonPressed, isTrue);
    });

    testWidgets('NeomorphicButton should change appearance when pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(
          Center(
            child: NeomorphicButton(
              onPressed: () {},
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      // Get the initial shadow state
      final buttonFinder = find.byType(AnimatedContainer);
      final AnimatedContainer initialContainer = tester.widget(buttonFinder);
      final BoxDecoration initialDecoration =
          initialContainer.decoration as BoxDecoration;
      final List<BoxShadow> initialShadows = initialDecoration.boxShadow!;

      // Press down on button (but don't release yet)
      final gesture = await tester.press(find.byType(NeomorphicButton));
      await tester.pump();

      // Verify the shadow changed
      final AnimatedContainer pressedContainer = tester.widget(buttonFinder);
      final BoxDecoration pressedDecoration =
          pressedContainer.decoration as BoxDecoration;
      final List<BoxShadow> pressedShadows = pressedDecoration.boxShadow!;

      // The pressed shadow should be different from initial shadow
      expect(pressedShadows[0].offset, isNot(equals(initialShadows[0].offset)));
      expect(
        pressedShadows[0].blurRadius,
        isNot(equals(initialShadows[0].blurRadius)),
      );

      // Release the button
      await gesture.up();
      await tester.pump();
    });

    testWidgets('NeomorphicButton should respect custom properties', (
      WidgetTester tester,
    ) async {
      const customBorderRadius = 20.0;
      const customBlurRadius = 15.0;
      const customColor = Colors.amber;

      await tester.pumpWidget(
        createTestWidget(
          Center(
            child: NeomorphicButton(
              onPressed: () {},
              borderRadius: customBorderRadius,
              blurRadius: customBlurRadius,
              backgroundColor: customColor,
              child: const Text('Custom Button'),
            ),
          ),
        ),
      );

      // Verify custom properties were applied
      final buttonFinder = find.byType(AnimatedContainer);
      final AnimatedContainer container = tester.widget(buttonFinder);
      final BoxDecoration decoration = container.decoration as BoxDecoration;

      expect(
        decoration.borderRadius,
        equals(BorderRadius.circular(customBorderRadius)),
      );
      expect(decoration.color, equals(customColor));

      // Check blur radius on the shadow
      expect(decoration.boxShadow![0].blurRadius, equals(customBlurRadius));
    });
  });

  group('GlassyCard Tests', () {
    testWidgets('GlassyCard should render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(
          Center(
            child: GlassyCard(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Glassy Content'),
              ),
            ),
          ),
        ),
      );

      // Verify card exists
      expect(find.text('Glassy Content'), findsOneWidget);
      expect(find.byType(GlassyCard), findsOneWidget);

      // Verify basic structure
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('GlassyCard should respect custom properties', (
      WidgetTester tester,
    ) async {
      const customBorderRadius = 25.0;
      const customBlurAmount = 10.0;
      const customBackgroundColor = Colors.red;
      const customBorderWidth = 2.0;
      const customBorderColor = Colors.green;

      await tester.pumpWidget(
        createTestWidget(
          Center(
            child: GlassyCard(
              borderRadius: customBorderRadius,
              blurAmount: customBlurAmount,
              backgroundColor: customBackgroundColor,
              borderWidth: customBorderWidth,
              borderColor: customBorderColor,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Custom Glassy Card'),
              ),
            ),
          ),
        ),
      );

      // Verify custom properties were applied
      final clipRRectFinder = find.byType(ClipRRect);
      final ClipRRect clipRRect = tester.widget(clipRRectFinder);

      expect(
        clipRRect.borderRadius,
        equals(BorderRadius.circular(customBorderRadius)),
      );

      final backdropFilterFinder = find.byType(BackdropFilter);
      final BackdropFilter backdropFilter = tester.widget(backdropFilterFinder);

      expect(backdropFilter.filter.toString(), contains('$customBlurAmount'));

      // Find the container with decoration
      final containerFinder = find.descendant(
        of: find.byType(BackdropFilter),
        matching: find.byType(Container),
      );

      final Container container = tester.widget(containerFinder);
      final BoxDecoration decoration = container.decoration as BoxDecoration;

      expect(decoration.border?.top.width, equals(customBorderWidth));
      expect(
        decoration.borderRadius,
        equals(BorderRadius.circular(customBorderRadius)),
      );
    });

    testWidgets('GlassyCard should handle child widgets properly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        createTestWidget(
          Center(
            child: GlassyCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star),
                  Text('Multiple Children'),
                  SizedBox(height: 10),
                  Text('Should Render'),
                ],
              ),
            ),
          ),
        ),
      );

      // Verify all child widgets render correctly
      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('Multiple Children'), findsOneWidget);
      expect(find.text('Should Render'), findsOneWidget);
    });
  });
}
