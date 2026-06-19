import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/models/discovery/discovery.dart' show DiscoveryError;
import 'package:echo_frame/models/folder_tree.dart' show FolderTree;
import 'package:echo_frame/models/import/import.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart'
    show ContextExtensions, StringExtensions;
import 'package:echo_frame/views/organizer/provider/import_provider.dart';
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

enum ImportType {
  mediaOrganizer,
  googleTakeoutOrganizer,
}

class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({
    super.key,
    required this.type,
  });

  final ImportType type;

  static const String path = '/import';

  static GoRoute get route => GoRoute(
        path: path,
        builder: (_, state) => ImportScreen(
          type: state.extra as ImportType,
        ),
      );

  @override
  ConsumerState<ImportScreen> createState() => _OrganizerScreenState();
}

class _OrganizerScreenState extends ConsumerState<ImportScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(importProvider(widget.type));

    if (state.destRoot == null) return _destRouteErrorView();

    return switch (state.phase) {
      ImportPhase.idle => IdleView(state, widget.type),
      ImportPhase.review => ReviewView(state, widget.type),
      ImportPhase.error => ErrorView(state, widget.type),
      ImportPhase.discovering => DiscoveringView(state),
      ImportPhase.applying => ApplyingView(state),
      ImportPhase.done => DoneView(state),
    };
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
