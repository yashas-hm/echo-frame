import 'package:echo_frame/services/indexing_service.dart';

class IndexingProgress {
  const IndexingProgress({
    required this.phase,
    this.currentDir,
    this.filesFound = 0,
    this.newFiles = 0,
  });

  final IndexingPhase phase;
  final String? currentDir;
  final int filesFound;

  /// Files that were not previously in the DB (only meaningful during reading phase).
  final int newFiles;

  bool get isDone => phase == IndexingPhase.done;
}