import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/constants/constants.dart' show Keys;
import 'package:media_metadata_plus/media_metadata_plus.dart';

class ThumbnailService {
  /// Returns the canonical thumbnail path for [videoPath].
  /// Thumbnails always live at the original (non-trash) location — the
  /// `.echotrash/` segment is stripped so trashed files resolve to the same
  /// thumb path as before they were trashed.
  static String pathFor(String videoPath) {
    final effectivePath = videoPath.contains('/${Keys.trashFolderName}/')
        ? videoPath.replaceFirst('/${Keys.trashFolderName}/', '/')
        : videoPath;
    final dir = effectivePath.substring(0, effectivePath.lastIndexOf('/'));
    final filename = effectivePath.split('/').last;
    return '$dir/${Keys.thumbsFolderName}/$filename.jpg';
  }

  /// Generates a JPEG thumbnail for [videoPath] via media_metadata_plus.
  /// Returns the thumbnail path on success, null if extraction fails.
  /// Skips generation if the thumbnail file already exists.
  static Future<String?> generate(String videoPath) async {
    final thumbPath = pathFor(videoPath);

    if (File(thumbPath).existsSync()) return thumbPath;

    try {
      await Directory(thumbPath).parent.create(recursive: true);

      final bytes = await MediaMetadata.generateThumbnail(
        videoPath,
        savePath: thumbPath,
      );

      if (bytes == null) return null;
      return thumbPath;
    } catch (e, st) {
      dev.log(
        'Thumbnail generation failed for $videoPath: $e',
        stackTrace: st,
        name: 'ThumbnailService.generate',
      );
      return null;
    }
  }
}
