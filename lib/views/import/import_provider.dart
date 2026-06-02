import 'package:echo_frame/models/google_takeout/import_result.dart';
import 'package:echo_frame/services/takeout_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/timeline/timeline_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ImportPhase { idle, discovering, review, importing, done, error }

class ImportState {
  final ImportPhase phase;
  final String? takeoutDir;
  final String? libraryRoot;
  final DiscoverResult? discovered;
  final int imported;
  final int total;
  final String? error;

  const ImportState({
    this.phase = ImportPhase.idle,
    this.takeoutDir,
    this.libraryRoot,
    this.discovered,
    this.imported = 0,
    this.total = 0,
    this.error,
  });

  ImportState copyWith({
    ImportPhase? phase,
    String? takeoutDir,
    String? libraryRoot,
    DiscoverResult? discovered,
    int? imported,
    int? total,
    String? error,
  }) =>
      ImportState(
        phase: phase ?? this.phase,
        takeoutDir: takeoutDir ?? this.takeoutDir,
        libraryRoot: libraryRoot ?? this.libraryRoot,
        discovered: discovered ?? this.discovered,
        imported: imported ?? this.imported,
        total: total ?? this.total,
        error: error ?? this.error,
      );
}

class ImportNotifier extends Notifier<ImportState> {
  @override
  ImportState build() => ImportState(libraryRoot: Prefs.libraryRootPath);

  Future<void> discover(String takeoutDir) async {
    state = state.copyWith(
      phase: ImportPhase.discovering,
      takeoutDir: takeoutDir,
    );

    try {
      final result = await TakeoutService.discover(takeoutDir);
      state = state.copyWith(
        phase: ImportPhase.review,
        discovered: result,
      );
    } catch (e) {
      state = state.copyWith(phase: ImportPhase.error, error: e.toString());
    }
  }

  Future<void> apply() async {
    final discovered = state.discovered;
    final libraryRoot = state.libraryRoot;
    if (discovered == null || libraryRoot == null) return;

    final pairs = discovered.pairs;
    final batchId = DateTime.now().millisecondsSinceEpoch.toString();

    state = state.copyWith(
      phase: ImportPhase.importing,
      imported: 0,
      total: pairs.length,
    );

    try {
      await for (final progress in TakeoutService.apply(
        pairs: pairs,
        libraryRoot: libraryRoot,
        batchId: batchId,
      )) {
        state = state.copyWith(imported: progress.imported);
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
