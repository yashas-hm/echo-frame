part of 'import.dart';

enum ImportPhase { idle, discovering, review, applying, done, error }

class ImportState {
  const ImportState({
    this.phase = ImportPhase.idle,
    this.sourceDir,
    this.destRoot,
    this.plan,
    this.applied = 0,
    this.total = 0,
    this.scanningDir,
    this.filesFound = 0,
    this.metaFilesRead = 0,
    this.metaFilesTotal = 0,
    this.applyErrors = const [],
    this.error,
  });

  final ImportPhase phase;
  final String? sourceDir;
  final String? destRoot;
  final DiscoveryResult? plan;
  final int applied;
  final int total;
  final String? scanningDir;
  final int filesFound;
  final int metaFilesRead;
  final int metaFilesTotal;
  final List<DiscoveryError> applyErrors;
  final String? error;

  ImportState copyWith({
    ImportPhase? phase,
    String? sourceDir,
    String? destRoot,
    DiscoveryResult? plan,
    int? applied,
    int? total,
    String? scanningDir,
    int? filesFound,
    int? metaFilesRead,
    int? metaFilesTotal,
    List<DiscoveryError>? applyErrors,
    String? error,
  }) =>
      ImportState(
        phase: phase ?? this.phase,
        sourceDir: sourceDir ?? this.sourceDir,
        destRoot: destRoot ?? this.destRoot,
        plan: plan ?? this.plan,
        applied: applied ?? this.applied,
        total: total ?? this.total,
        scanningDir: scanningDir ?? this.scanningDir,
        filesFound: filesFound ?? this.filesFound,
        metaFilesRead: metaFilesRead ?? this.metaFilesRead,
        metaFilesTotal: metaFilesTotal ?? this.metaFilesTotal,
        applyErrors: applyErrors ?? this.applyErrors,
        error: error ?? this.error,
      );
}