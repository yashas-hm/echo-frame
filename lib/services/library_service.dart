import 'dart:io';

import 'package:echo_frame/models/timeline/timeline_models.dart';
import 'package:intl/intl.dart';

class LibraryStructure {
  final List<MonthFolder> months;
  final List<String> unsorted;

  const LibraryStructure({required this.months, required this.unsorted});
}

class LibraryService {
  static const _videoExts = {'mp4', 'mov', 'avi', 'mkv', 'm4v'};

  static bool isVideo(String path) =>
      _videoExts.contains(path.split('.').last.toLowerCase());

  static const _mediaExts = {
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

  static bool isMedia(String path) =>
      _mediaExts.contains(path.split('.').last.toLowerCase());

  static Future<LibraryStructure> discover(String root) async {
    final organized = <MonthFolder>[];
    final unsorted = <String>[];

    await for (final entry in Directory(root).list()) {
      if (entry is Directory) {
        final name = entry.path.split('/').last;
        final year = int.tryParse(name);
        if (year != null && year > 1900 && year < 2100) {
          await for (final sub in entry.list()) {
            if (sub is Directory) {
              final folderName = sub.path.split('/').last;
              int? month;
              try {
                month = DateFormat('MMMM').parseStrict(folderName).month;
              } catch (_) {}
              if (month != null) {
                organized.add(MonthFolder(
                  year: year,
                  month: month,
                  path: sub.path,
                ));
              }
            }
          }
        }
      } else if (entry is File && isMedia(entry.path)) {
        unsorted.add(entry.path);
      }
    }

    organized.sort((a, b) => b.compareTo(a));
    return LibraryStructure(months: organized, unsorted: unsorted);
  }
}
