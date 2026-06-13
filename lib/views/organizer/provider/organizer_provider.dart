import 'package:echo_frame/models/organizer_result.dart';
import 'package:echo_frame/models/timeline/timeline_models.dart';
import 'package:echo_frame/services/indexing_pipeline.dart';
import 'package:echo_frame/services/organizer_service.dart';
import 'package:echo_frame/utilities/utilities.dart' show Prefs;
import 'package:echo_frame/views/timeline/provider/timeline_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum OrganizerPhase { idle, previewing, preview, applying, done, error }

class OrganizerState {
  final OrganizerPhase phase;
  final String? sourceDir;
  final String? destRoot;
  final List<OperationResult> operations;
  final int applied;
  final int total;
  final String? error;
  final String? lastBatchId;
  final int? rolledBack;

  const OrganizerState({
    this.phase = OrganizerPhase.idle,
    this.sourceDir,
    this.destRoot,
    this.operations = const [],
    this.applied = 0,
    this.total = 0,
    this.error,
    this.lastBatchId,
    this.rolledBack,
  });

  OrganizerState copyWith({
    OrganizerPhase? phase,
    String? sourceDir,
    String? destRoot,
    List<OperationResult>? operations,
    int? applied,
    int? total,
    String? error,
    String? lastBatchId,
    int? rolledBack,
  }) =>
      OrganizerState(
        phase: phase ?? this.phase,
        sourceDir: sourceDir ?? this.sourceDir,
        destRoot: destRoot ?? this.destRoot,
        operations: operations ?? this.operations,
        applied: applied ?? this.applied,
        total: total ?? this.total,
        error: error ?? this.error,
        lastBatchId: lastBatchId ?? this.lastBatchId,
        rolledBack: rolledBack ?? this.rolledBack,
      );
}

class OrganizerNotifier extends Notifier<OrganizerState> {
  @override
  OrganizerState build() => OrganizerState(destRoot: Prefs.libraryRootPath);

  Future<void> preview(String sourceDir) async {
    final destRoot = state.destRoot;
    if (destRoot == null) return;

    state = state.copyWith(
      phase: OrganizerPhase.previewing,
      sourceDir: sourceDir,
    );

    try {
      final ops = await OrganizerService.preview(
        sourceDir: sourceDir,
        destRoot: destRoot,
      );
      state = state.copyWith(phase: OrganizerPhase.preview, operations: ops);
    } catch (e) {
      state = state.copyWith(phase: OrganizerPhase.error, error: e.toString());
    }
  }

  Future<void> apply() async {
    final ops = state.operations;
    if (ops.isEmpty) return;

    final batchId = DateTime.now().millisecondsSinceEpoch.toString();
    state = state.copyWith(
      phase: OrganizerPhase.applying,
      applied: 0,
      total: ops.length,
      lastBatchId: batchId,
    );

    try {
      await for (final progress in OrganizerService.apply(
        operations: ops,
        batchId: batchId,
      )) {
        state = state.copyWith(applied: progress.applied);
      }

      final destRoot = state.destRoot!;
      final affectedMonths = _extractAffectedMonths(ops, destRoot);
      if (affectedMonths.isNotEmpty) {
        await for (final _ in IndexingPipeline.run(
          libraryRoot: destRoot,
          months: affectedMonths,
        )) {}
      }

      ref.invalidate(timelineProvider);
      state = state.copyWith(phase: OrganizerPhase.done);
    } catch (e) {
      state = state.copyWith(phase: OrganizerPhase.error, error: e.toString());
    }
  }

  Future<void> rollback() async {
    final batchId = state.lastBatchId;
    if (batchId == null) return;

    try {
      final count = await OrganizerService.rollback(batchId);
      ref.invalidate(timelineProvider);
      state = OrganizerState(
        destRoot: state.destRoot,
        rolledBack: count,
      );
    } catch (e) {
      state = state.copyWith(phase: OrganizerPhase.error, error: e.toString());
    }
  }

  void reset() => state = OrganizerState(destRoot: state.destRoot);

  List<MonthFolder> _extractAffectedMonths(
    List<OperationResult> ops,
    String destRoot,
  ) {
    final seen = <String>{};
    final months = <MonthFolder>[];

    for (final op in ops) {
      final parts = op.destRelative.split('/');
      if (parts.length < 2) continue;
      final key = '${parts[0]}/${parts[1]}';
      if (!seen.add(key)) continue;

      final year = int.tryParse(parts[0]);
      final monthIdx = MonthFolder.monthNames.indexOf(parts[1]);
      if (year == null || monthIdx < 0) continue;

      months.add(MonthFolder(
        year: year,
        month: monthIdx + 1,
        path: '$destRoot/${parts[0]}/${parts[1]}',
      ));
    }

    return months;
  }
}

final organizerProvider =
    NotifierProvider<OrganizerNotifier, OrganizerState>(OrganizerNotifier.new);
