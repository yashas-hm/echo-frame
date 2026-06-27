import 'package:echo_frame/components/empty_view.dart';
import 'package:echo_frame/components/error_view.dart';
import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/services/importing/import_service.dart';
import 'package:echo_frame/services/importing/organizer_service.dart';
import 'package:echo_frame/services/importing/takeout_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/import/components/views.dart';
import 'package:echo_frame/views/media/timeline/timeline_screen.dart'
    show timelineProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'provider/import_provider.dart';
part 'provider/import_state.dart';

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
