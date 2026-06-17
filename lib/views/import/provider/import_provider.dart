import 'package:echo_frame/models/google_takeout/discover_event.dart';
import 'package:echo_frame/models/google_takeout/discovery_error.dart';
import 'package:echo_frame/models/google_takeout/import_plan.dart';
import 'package:echo_frame/services/takeout_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ImportPhase { idle, discovering, review, importing, done, error }

class ImportState {
  const ImportState({
    this.phase = ImportPhase.idle,
    this.takeoutDir,
    this.libraryRoot,
    this.plan,
    this.imported = 0,
    this.total = 0,
    this.scanningDir,
    this.filesFound = 0,
    this.applyErrors = const [],
    this.error,
  });

  final ImportPhase phase;
  final String? takeoutDir;
  final String? libraryRoot;
  final ImportPlan? plan;
  final int imported;
  final int total;
  final String? scanningDir;
  final int filesFound;
  final List<DiscoveryError> applyErrors;
  final String? error;

  ImportState copyWith({
    ImportPhase? phase,
    String? takeoutDir,
    String? libraryRoot,
    ImportPlan? plan,
    int? imported,
    int? total,
    String? scanningDir,
    int? filesFound,
    List<DiscoveryError>? applyErrors,
    String? error,
  }) =>
      ImportState(
        phase: phase ?? this.phase,
        takeoutDir: takeoutDir ?? this.takeoutDir,
        libraryRoot: libraryRoot ?? this.libraryRoot,
        plan: plan ?? this.plan,
        imported: imported ?? this.imported,
        total: total ?? this.total,
        scanningDir: scanningDir ?? this.scanningDir,
        filesFound: filesFound ?? this.filesFound,
        applyErrors: applyErrors ?? this.applyErrors,
        error: error ?? this.error,
      );
}

class ImportNotifier extends Notifier<ImportState> {
  @override
  ImportState build() => ImportState(libraryRoot: Prefs.libraryRootPath);

  Future<void> discover(String takeoutDir) async {
    final libraryRoot = state.libraryRoot;
    if (libraryRoot == null) return;

    state = state.copyWith(
      phase: ImportPhase.discovering,
      takeoutDir: takeoutDir,
      filesFound: 0,
      scanningDir: null,
    );

    try {
      await for (final event in TakeoutService.discover(
        takeoutDir: takeoutDir,
        libraryRoot: libraryRoot,
      )) {
        switch (event) {
          case DiscoverScanning(:final dirName, :final filesFound):
            state = state.copyWith(scanningDir: dirName, filesFound: filesFound);
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
    final libraryRoot = state.libraryRoot;
    if (plan == null || libraryRoot == null) return;

    final batchId = DateTime.now().millisecondsSinceEpoch.toString();

    state = state.copyWith(
      phase: ImportPhase.importing,
      imported: 0,
      total: plan.total,
      applyErrors: const [],
    );

    try {
      await for (final progress in TakeoutService.apply(
        plan: plan,
        libraryRoot: libraryRoot,
        batchId: batchId,
      )) {
        state = state.copyWith(
          imported: progress.imported,
          applyErrors: progress.errors,
        );
      }

      ref.invalidate(timelineProvider);
      state = state.copyWith(phase: ImportPhase.done);
    } catch (e) {
      state = state.copyWith(phase: ImportPhase.error, error: e.toString());
    }
  }

  void reset() => state = ImportState(libraryRoot: state.libraryRoot);
}

final importProvider =
    NotifierProvider<ImportNotifier, ImportState>(ImportNotifier.new);