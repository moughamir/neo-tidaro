/// Shared package for Neo-Tidaro applications
///
/// This package provides shared functionality that can be used across
/// different applications in the workspace.
library shared;

// Domain exports
export 'domain/entities/entity.dart';
export 'domain/repositories/generic_repository.dart';
export 'domain/models/models.dart';
export 'domain/enums/enums.dart' hide UserRole, BookingStatus;

// Data layer exports
export 'data/mappers/supabase_mappers.dart';

// Utils exports
export 'utils/extensions/datetime_extensions.dart';
export 'utils/extensions/string_extensions.dart';
export 'utils/failures/failure.dart';
export 'utils/type_defs.dart';
export 'utils/markdown_utils.dart';

// Widget exports
export 'widgets/buttons/primary_button.dart';
export 'widgets/containers/info_card.dart';
export 'widgets/dialogs/generic_dialog.dart';
export 'widgets/indicators/error_display.dart';
export 'widgets/indicators/loading_indicator.dart';
export 'widgets/layout/page_scaffold.dart';
export 'widgets/layout/responsive_layout.dart';
export 'widgets/lists/responsive_grid_view.dart';
export 'widgets/content/markdown_widget.dart';

// Redux exports
export 'redux/redux.dart';
