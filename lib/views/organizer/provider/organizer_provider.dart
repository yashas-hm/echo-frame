import 'package:echo_frame/models/discovery/discovery.dart';
import 'package:echo_frame/services/importing/organizer_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:echo_frame/services/importing/import_service.dart' show ImportProgress;

enum OrganizerPhase { idle, discovering, review, applying, done, error }

class OrganizerState {
  const OrganizerState({
    this.phase = OrganizerPhase.idle,
    this.sourceDir,
    this.destRoot,
    this.plan,
    this.applied = 0,
    this.total = 0,
    this.scanningDir,
    this.filesFound = 0,
    this.applyErrors = const [],
    this.error,
  });

  final OrganizerPhase phase;
  final String? sourceDir;
  final String? destRoot;
  final DiscoveryResult? plan;
  final int applied;
  final int total;
  final String? scanningDir;
  final int filesFound;
  final List<DiscoveryError> applyErrors;
  final String? error;

  OrganizerState copyWith({
    OrganizerPhase? phase,
    String? sourceDir,
    String? destRoot,
    DiscoveryResult? plan,
    int? applied,
    int? total,
    String? scanningDir,
    int? filesFound,
    List<DiscoveryError>? applyErrors,
    String? error,
  }) =>
      OrganizerState(
        phase: phase ?? this.phase,
        sourceDir: sourceDir ?? this.sourceDir,
        destRoot: destRoot ?? this.destRoot,
        plan: plan ?? this.plan,
        applied: applied ?? this.applied,
        total: total ?? this.total,
        scanningDir: scanningDir ?? this.scanningDir,
        filesFound: filesFound ?? this.filesFound,
        applyErrors: applyErrors ?? this.applyErrors,
        error: error ?? this.error,
      );
}

class OrganizerNotifier extends Notifier<OrganizerState> {
  final _service = OrganizerService();

  @override
  OrganizerState build() => OrganizerState(destRoot: Prefs.libraryRootPath);

  Future<void> discover(String sourceDir) async {
    final destRoot = state.destRoot;
    if (destRoot == null) return;

    state = state.copyWith(
      phase: OrganizerPhase.discovering,
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
            state = state.copyWith(phase: OrganizerPhase.review, plan: plan);
        }
      }
    } catch (e) {
      state = state.copyWith(phase: OrganizerPhase.error, error: e.toString());
    }
  }

  Future<void> apply() async {
    final plan = state.plan;
    final destRoot = state.destRoot;
    if (plan == null || destRoot == null) return;

    state = state.copyWith(
      phase: OrganizerPhase.applying,
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
      state = state.copyWith(phase: OrganizerPhase.done);
    } catch (e) {
      state = state.copyWith(phase: OrganizerPhase.error, error: e.toString());
    }
  }

  void reset() => state = OrganizerState(destRoot: state.destRoot);
}

final organizerProvider =
    NotifierProvider<OrganizerNotifier, OrganizerState>(OrganizerNotifier.new);