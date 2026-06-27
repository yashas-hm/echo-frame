part of '../import_screen.dart';

class ImportNotifier extends Notifier<ImportState> {
  ImportNotifier({required ImportService service}) : _service = service;
  final ImportService _service;

  @override
  ImportState build() => ImportState(destRoot: Prefs.activeLibraryRoot);

  void setSourceDir(String path) => state = state.copyWith(sourceDir: path);

  Future<void> discover(String sourceDir) async {
    final destRoot = state.destRoot;
    if (destRoot == null) return;

    state = state.copyWith(
      phase: ImportPhase.discovering,
      sourceDir: sourceDir,
      filesFound: 0,
      scanningDir: null,
      metaFilesRead: 0,
    );

    try {
      await for (final event in _service.discover(
        sourceDir: sourceDir,
        destRoot: destRoot,
      )) {
        switch (event) {
          case DiscoverScanning(:final dirName, :final filesFound):
            state = state.copyWith(
              scanningDir: dirName,
              filesFound: filesFound,
            );
          case DiscoverReading(:final done):
            state = state.copyWith(
              phase: ImportPhase.metaRead,
              metaFilesRead: done,
            );
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
