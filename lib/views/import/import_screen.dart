import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/models/discovery/discovery.dart' show DiscoveryError;
import 'package:echo_frame/models/folder_tree.dart' show FolderTree;
import 'package:echo_frame/models/import/import.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart'
    show ColorExtensions, ContextExtensions, StringExtensions;
import 'package:echo_frame/views/import/provider/import_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

part 'components/applying_view.dart';
part 'components/discovering_view.dart';
part 'components/done_view.dart';
part 'components/error_list.dart';
part 'components/error_view.dart';
part 'components/folder_tree_preview.dart';
part 'components/idle_view.dart';
part 'components/review_view.dart';
part 'components/type_selection_view.dart';

enum ImportType {
  mediaOrganizer,
  googleTakeoutOrganizer,
}

class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  static const String path = '/import';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, state) => ImportScreen(),
      );

  @override
  ConsumerState<ImportScreen> createState() => _OrganizerScreenState();
}

class _OrganizerScreenState extends ConsumerState<ImportScreen> {
  ImportType? _importType;

  @override
  Widget build(BuildContext context) {
    if (_importType != null) {
      final state = ref.watch(importProvider(_importType!));

      if (state.destRoot == null) return _destRouteErrorView();

      return switch (state.phase) {
        ImportPhase.review => ReviewView(state, _importType!),
        ImportPhase.error => ErrorView(state, _importType!),
        ImportPhase.discovering => DiscoveringView(state),
        ImportPhase.applying => ApplyingView(state),
        ImportPhase.done => DoneView(state),
        ImportPhase.idle => IdleView(
            state,
            _importType!,
            onBackPressed: () => setState(() => _importType = null),
          ),
      };
    }

    return TypeSelectionView(
      onSelectType: (type) => setState(() => _importType = type),
    );
  }

  Widget _destRouteErrorView() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_off_outlined,
              size: 56,
              color: context.colors.borderPrimary,
            ),
            const SizedBox(height: 16),
            Text('No library selected, set up a library first'),
          ],
        ),
      );
}
