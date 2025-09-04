/// Main library export file for the KUI shared package
///
/// This library provides Flutter widgets, utilities, and domain entities
/// using Material UI with Neumorphic styling for a consistent look and feel.
library kui_shared;

// Domain exports
export 'domain/entities/entity.dart';
export 'domain/repositories/generic_repository.dart';

// Utils exports
export 'utils/extensions/datetime_extensions.dart';
export 'utils/extensions/string_extensions.dart';
export 'utils/failures/failure.dart';
export 'utils/type_defs.dart';

// Widget exports
export 'widgets/buttons/primary_button.dart';
export 'widgets/containers/info_card.dart';
export 'widgets/dialogs/generic_dialog.dart';
export 'widgets/indicators/error_display.dart';
export 'widgets/indicators/loading_indicator.dart';
export 'widgets/layout/page_scaffold.dart';
export 'widgets/layout/responsive_layout.dart';
export 'widgets/lists/responsive_grid_view.dart';
