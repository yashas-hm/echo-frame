import 'package:echo_frame/database/daos/drive_dao.dart';
import 'package:echo_frame/database/daos/media_dao.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/models/timeline/timeline_models.dart';
import 'package:echo_frame/services/cache_service.dart';
import 'package:echo_frame/services/drive_service.dart';
import 'package:intl/intl.dart';

class IndexingProgress {
  final int completed;
  final int total;
  final String? currentFolder;
  final bool isDone;

  const IndexingProgress({
    required this.completed,
    required this.total,
    this.currentFolder,
    this.isDone = false,
  });

  factory IndexingProgress.done(int total) =>
      IndexingProgress(completed: total, total: total, isDone: true);

  double get fraction => total == 0 ? 1.0 : completed / total;
}

class IndexingService {
  static Stream<IndexingProgress> run({
    required String libraryRoot,
    required List<MonthFolder> months,
  }) async* {
    if (months.isEmpty) {
      yield IndexingProgress.done(0);
      return;
    }

    final uuid = await DriveService.volumeUuid(libraryRoot);
    final label = await DriveService.volumeLabel(libraryRoot);
    final db = EchoDatabase.instance;

    await DriveDao(db).upsertDrive(
      uuid: uuid,
      label: label,
      mountPath: libraryRoot,
    );

    final indexService = CacheService();
    final mediaDao = MediaDao(db);

    for (int i = 0; i < months.length; i++) {
      final folder = months[i];
      yield IndexingProgress(
        completed: i,
        total: months.length,
        currentFolder: '${folder.year}/${DateFormat('MMMM').format(DateTime(folder.year, folder.month))}',
      );

      final index = await indexService.getOrBuild(folder);
      await mediaDao.upsertFromIndex(
        index: index,
        folder: folder,
        driveId: uuid,
        libraryRoot: libraryRoot,
      );
    }

    yield IndexingProgress.done(months.length);
  }
}
