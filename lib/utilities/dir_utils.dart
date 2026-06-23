part of 'utilities.dart';

class DirUtils {
  static bool isMedia(String path) =>
      _mediaExts.contains(path.split('.').last.toLowerCase());

  static bool isVideo(String path) =>
      _videoExts.contains(path.split('.').last.toLowerCase());

  /// BFS walk of [root]. Yields one [DirScan] per directory visited,
  /// including media paths and JSON filenames found in that directory.
  static Stream<DirScan> walk(String root) async* {
    final queue = Queue<Directory>()..add(Directory(root));

    while (queue.isNotEmpty) {
      final dir = queue.removeFirst();

      List<FileSystemEntity> entries;
      try {
        entries = dir.listSync();
      } catch (e, st) {
        dev.log(
          'Failed to list ${dir.path}: $e',
          stackTrace: st,
          name: 'DirUtils.walk',
        );
        continue;
      }

      final mediaPaths = <String>[];
      final jsonByName = <String, String>{};

      for (final e in entries) {
        if (e is! File) continue;
        if (e.path.endsWith('.json')) {
          jsonByName[e.path.split('/').last] = e.path;
        } else if (isMedia(e.path)) {
          mediaPaths.add(e.path);
        }
      }

      yield DirScan(
        dirName: dir.path.split('/').last,
        mediaPaths: mediaPaths,
        jsonByName: jsonByName,
      );

      for (final e in entries) {
        if (e is Directory && e.path.split('/').last != Keys.thumbsFolderName) {
          queue.add(e);
        }
      }
    }
  }

  static const Set<String> _mediaExts = {
    'jpg',
    'jpeg',
    'png',
    'heic',
    'heif',
    'webp',
    'tiff',
    'tif',
    'mp4',
    'mov',
    'avi',
    'mkv',
    'm4v',
  };

  static const Set<String> _videoExts = {'mp4', 'mov', 'avi', 'mkv', 'm4v'};
}
