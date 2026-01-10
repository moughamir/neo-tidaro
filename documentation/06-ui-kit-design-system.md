---
created_date: 10/09/2025
updated_date: 20/11/2025
---
# UI Kit Design System

The Neo-Tidaro UI Kit features a centralized, unified design system that consolidates all previous theme implementations into a single, cohesive foundation. This document outlines the architecture, usage patterns, and migration guide for the new design system.

## 🎯 Overview

The unified design system replaces multiple scattered theme implementations with:

- **Centralized Design Tokens**: Single source of truth for spacing, colors, typography, and effects
- **Unified Theme System**: Replaces `AppTheme`, `NeumorphicTheme`, and `TidaroColorPalette`
- **Consolidated Components**: `UnifiedButton` and `UnifiedCard` replace multiple duplicate implementations
- **Effect System**: Consistent Neumorphism and Glassmorphism effects across all components

## 📁 Architecture

```
packages/ui_kit/lib/src/design_system/
├── design_tokens.dart      # Centralized tokens (spacing, colors, effects)
├── effects.dart           # Neumorphic & glassmorphic effect system
├── kui_theme.dart         # Complete theme system
└── design_system.dart     # Barrel export
```

## 🎨 Design Tokens

### Spacing System

```dart
// Consistent spacing scale
DesignTokens.space1    // 4px
DesignTokens.space2    // 8px
DesignTokens.space3    // 12px
DesignTokens.space4    // 16px
DesignTokens.space6    // 24px
DesignTokens.space8    // 32px
DesignTokens.space12   // 48px
DesignTokens.space16   // 64px
DesignTokens.space20   // 80px
DesignTokens.space24   // 96px
```

### Border Radius

```dart
DesignTokens.radiusXs   // 2px
DesignTokens.radiusSm   // 4px
DesignTokens.radiusMd   // 6px
DesignTokens.radiusLg   // 8px
DesignTokens.radiusXl   // 12px
DesignTokens.radius2xl  // 16px
DesignTokens.radius3xl  // 24px
```

### Color System

```dart
// Access semantic colors for current theme
final colors = DesignTokens.colorsFor(brightness);

// Core brand colors
colors.primary
colors.secondary
colors.tertiary

// Surface colors
colors.surface
colors.surfaceVariant
colors.background

// State colors
colors.success
colors.warning
colors.error
colors.info

// Neumorphic colors
colors.neuShadowDark
colors.neuHighlight

// Glassmorphic colors
colors.glassOverlay
colors.glassBorder
```

## ✨ Effects System

### Neumorphic Effects

```dart
// Elevated (raised) effect
DesignEffects.neumorphicElevated(
  colors: colors,
  radius: DesignTokens.radiusLg,
)

// Inset (pressed) effect
DesignEffects.neumorphicInset(
  colors: colors,
  radius: DesignTokens.radiusLg,
)

// Flat (neutral) effect
DesignEffects.neumorphicFlat(
  colors: colors,
  radius: DesignTokens.radiusLg,
)
```

### Glassmorphic Effects

```dart
// Glass container with backdrop blur
DesignEffects.glassContainer(
  child: myWidget,
  colors: colors,
  radius: DesignTokens.radiusLg,
)

// Glass decoration only
DesignEffects.glassmorphic(
  colors: colors,
  radius: DesignTokens.radiusLg,
)
```

### Hybrid Effects

```dart
// Combines neumorphic shadows with glass overlay
DesignEffects.hybridCard(
  child: myWidget,
  colors: colors,
  radius: DesignTokens.radiusLg,
)
```

### Elevation System

```dart
// Material Design elevation levels (0-5)
DesignEffects.elevationLevel(
  colors: colors,
  level: 2, // 0 = flat, 5 = highest elevation
  radius: DesignTokens.radiusLg,
)
```

## 🎨 Unified Theme

### Setup

```dart
import 'package:ui_kit/ui_kit.dart';

MaterialApp(
  theme: KuiTheme.light(),
  darkTheme: KuiTheme.dark(),
  themeMode: ThemeMode.system,
  // ... rest of app
)
```

### Helper Methods

```dart
// Get colors for current theme
final colors = KuiTheme.colorsOf(context);

// Create neumorphic decoration
final decoration = KuiTheme.neumorphicOf(context, elevation: 2);

// Create glass container
final glassWidget = KuiTheme.glassOf(
  context,
  child: myWidget,
);

// Create hybrid effect
final hybridWidget = KuiTheme.hybridOf(
  context,
  child: myWidget,
);
```

## 🧩 Unified Components

### UnifiedButton

Replaces `NeomorphicButton`, `PrimaryButton`, and other button duplicates:

```dart
// Primary button (elevated style)
UnifiedButton.primary(
  onPressed: () {},
  child: Text('Primary'),
)

// Neumorphic button
UnifiedButton.neumorphic(
  onPressed: () {},
  child: Text('Neumorphic'),
)

// Glassmorphic button
UnifiedButton.glass(
  onPressed: () {},
  child: Text('Glass'),
)

// Outlined button
UnifiedButton.outlined(
  onPressed: () {},
  child: Text('Outlined'),
)

// Text button
UnifiedButton.text(
  onPressed: () {},
  child: Text('Text'),
)

// With advanced features
UnifiedButton.primary(
  onPressed: () {},
  child: Text('Advanced'),
  size: ButtonSize.large,
  icon: Icon(Icons.star),
  isLoading: isLoading,
  tooltip: 'This is a tooltip',
)
```

### UnifiedCard

Replaces `KuiCard.glass` and other card duplicates:

```dart
// Elevated card with neumorphic shadows
UnifiedCard.elevated(
  child: Text('Content'),
  title: 'Card Title',
  subtitle: 'Card subtitle',
)

// Glassmorphic card
UnifiedCard.glass(
  child: Text('Content'),
  title: 'Glass Card',
)

// Outlined card
UnifiedCard.outlined(
  child: Text('Content'),
)

// Hybrid card (neumorphic + glass)
UnifiedCard.hybrid(
  child: Text('Content'),
)
```

### Specialized Cards

```dart
// Metric card for dashboards
MetricCard(
  title: 'Total Users',
  value: '1,234',
  trend: '+12%',
  isPositiveTrend: true,
  icon: Icon(Icons.people),
)

// Activity card for timelines
ActivityCard(
  title: 'User signed up',
  description: 'New user registration',
  timestamp: DateTime.now(),
  avatar: CircleAvatar(child: Text('U')),
)
```

## 🔄 Migration Guide

### From Legacy Themes

**Before:**

```dart
// Old scattered approach
import 'package:ui_kit/src/theme/app_theme.dart';
import 'package:ui_kit/src/theme/neumorphic_theme.dart';
import 'package:ui_kit/src/theme/palette.dart';

MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
)
```

**After:**

```dart
// New unified approach
import 'package:ui_kit/ui_kit.dart';

MaterialApp(
  theme: UnifiedTheme.light(),
  darkTheme: UnifiedTheme.dark(),
)
```

### From Legacy Components

**Before:**

```dart
// Multiple button implementations
NeomorphicButton(onPressed: () {}, child: Text('Neo'))
PrimaryButton(onPressed: () {}, child: Text('Primary'))
```

**After:**

```dart
// Single unified component
UnifiedButton.neumorphic(onPressed: () {}, child: Text('Neo'))
UnifiedButton.primary(onPressed: () {}, child: Text('Primary'))
```

**Before:**

```dart
// Multiple card implementations
KuiCard.glass(title: 'Glass', child: content)
// Various other card widgets...
```

**After:**

```dart
// Single unified component
UnifiedCard.glass(title: 'Glass', child: content)
UnifiedCard.elevated(title: 'Elevated', child: content)
```

## 🎯 Best Practices

### 1. Use Design Tokens

```dart
// ✅ Good - Use design tokens
Container(
  padding: EdgeInsets.all(DesignTokens.space4),
  margin: EdgeInsets.all(DesignTokens.space2),
)

// ❌ Bad - Hardcoded values
Container(
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
)
```

### 2. Use Unified Components

```dart
// ✅ Good - Use unified components
UnifiedButton.primary(
  onPressed: onPressed,
  child: Text('Submit'),
)

// ❌ Bad - Use deprecated components
PrimaryButton(
  onPressed: onPressed,
  child: Text('Submit'),
)
```

### 3. Use Theme Helpers

```dart
// ✅ Good - Use theme helpers
final decoration = UnifiedTheme.neumorphicOf(context);

// ❌ Bad - Manual effect creation
final decoration = DesignEffects.neumorphicElevated(
  colors: DesignTokens.colorsFor(Theme.of(context).brightness),
  // ... manual configuration
);
```

### 4. Consistent Effects

```dart
// ✅ Good - Use elevation system
DesignEffects.elevationLevel(colors: colors, level: 2)

// ❌ Bad - Custom shadow configurations
BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(2, 2))
```

## 📊 Component Status

### ✅ Unified Components (Use These)

- `UnifiedButton` - All button variants
- `UnifiedCard` - All card variants
- `MetricCard` - Dashboard metrics
- `ActivityCard` - Timeline activities

### ⚠️ Deprecated Components (Migrate Away)

- `NeomorphicButton` → `UnifiedButton.neumorphic`
- `PrimaryButton` → `UnifiedButton.primary`
- `KuiCard.glass` → `UnifiedCard.glass`
- Various other card components → `UnifiedCard.*`

### 🔄 Legacy Theme System

- `AppTheme` → `KuiTheme`
- `NeumorphicTheme` → `DesignEffects`
- `TidaroColorPalette` → `DesignTokens.colorsFor()`

## 🚀 Future Enhancements

1. **Input Components**: Unified input field system
2. **Navigation Components**: Unified navigation patterns
3. **Layout Components**: Enhanced responsive system
4. **Animation System**: Consistent motion design
5. **Accessibility**: Enhanced a11y support

## 📝 Contributing

When adding new components:

1. Use design tokens for all spacing, colors, and effects
2. Follow the unified component pattern
3. Support both light and dark themes
4. Include comprehensive documentation
5. Add examples to the UI Kit showcase

## 🔗 Related Documentation

- [Getting Started](./01-getting-started.md)
- [Workspace Structure](./01-workspace-structure.md)
- [Coding Conventions](./02-coding-conventions.md)
- [Platform Support](./05-platform-support.md)
