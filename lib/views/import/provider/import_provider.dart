import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/models/import/import.dart';
import 'package:echo_frame/services/importing/import_service.dart';
import 'package:echo_frame/services/importing/organizer_service.dart';
import 'package:echo_frame/services/importing/takeout_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/import/import_screen.dart';
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImportNotifier extends Notifier<ImportState> {
  ImportNotifier({required ImportService service}) : _service = service;
  final ImportService _service;

  @override
  ImportState build() => ImportState(destRoot: Prefs.libraryRootPath);

  void setSourceDir(String path) => state = state.copyWith(sourceDir: path);

  Future<void> discover(String sourceDir) async {
    final destRoot = state.destRoot;
    if (destRoot == null) return;

    state = state.copyWith(
      phase: ImportPhase.discovering,
      sourceDir: sourceDir,
      filesFound: 0,
      scanningDir: null,
    );

    try {
      await for (final event in _service.discover(
        sourceDir: sourceDir,
        destRoot: destRoot,
      )) {
        switch (event) {
          case DiscoverScanning(:final dirName, :final filesFound):
            state =
                state.copyWith(scanningDir: dirName, filesFound: filesFound);
          case DiscoverDone(:final plan):
            state = state.copyWith(phase: ImportPhase.review, plan: plan);
        }
      }
    } catch (e) {
      state = state.copyWith(phase: ImportPhase.error, error: e.toString());
    }
  }

  Future<void> apply() async {
    final plan = state.plan;
    final destRoot = state.destRoot;
    if (plan == null || destRoot == null) return;

    state = state.copyWith(
      phase: ImportPhase.applying,
      applied: 0,
      total: plan.total,
      applyErrors: const [],
    );

    try {
      await for (final progress in _service.apply(
        plan: plan,
        libraryRoot: destRoot,
      )) {
        state = state.copyWith(
          applied: progress.imported,
          applyErrors: progress.errors,
        );
      }

      ref.invalidate(timelineProvider);
      state = state.copyWith(phase: ImportPhase.done);
    } catch (e) {
      state = state.copyWith(phase: ImportPhase.error, error: e.toString());
    }
  }

  void reset() => state = ImportState(destRoot: state.destRoot);
}

final importProvider =
    NotifierProvider.family<ImportNotifier, ImportState, ImportType>(
  (type) => ImportNotifier(
    service: switch (type) {
      ImportType.mediaOrganizer => OrganizerService(),
      ImportType.googleTakeoutOrganizer => TakeoutService(),
    },
  ),
);
