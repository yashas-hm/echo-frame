import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/components/empty_view.dart';
import 'package:echo_frame/components/error_view.dart';
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
part 'components/folder_tree_preview.dart';
part 'components/idle_view.dart';
part 'components/meta_read_view.dart';
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

      if (state.destRoot == null) {
        return Scaffold(
          body: const EmptyView(
            icon: Icons.folder_off_outlined,
            title: 'No library selected',
            message: 'Set up a library before importing',
          ),
        );
      }

      return Scaffold(
        body: switch (state.phase) {
          ImportPhase.idle => IdleView(
              state,
              _importType!,
              onBackPressed: () => setState(() => _importType = null),
            ),
          ImportPhase.discovering => DiscoveringView(state),
          ImportPhase.metaRead => MetaReadView(state),
          ImportPhase.review => ReviewView(state, _importType!),
          ImportPhase.applying => ApplyingView(state),
          ImportPhase.done => DoneView(state, _importType!),
          ImportPhase.error => ErrorView(
              onButtonPressed:
                  ref.read(importProvider(_importType!).notifier).reset,
              description: state.error,
              buttonText: 'Start Over',
            ),
        },
      );
    }

    return TypeSelectionView(
      onSelectType: (type) => setState(() => _importType = type),
    );
  }
}
