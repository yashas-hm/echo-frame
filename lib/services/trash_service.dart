import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/constants/constants.dart' show Keys;
import 'package:echo_frame/services/thumbnail_service.dart';

class TrashService {
  /// Moves [filePath] into `.echotrash`, preserving the relative structure.
  /// Returns the new absolute path on success, null if the move failed.
  static Future<String?> trash(String filePath, String libraryRoot) async {
    final relative = filePath.substring(libraryRoot.length + 1);
    final trashPath = '$libraryRoot/${Keys.trashFolderName}/$relative';
    final moved = await _move(filePath, trashPath);
    return moved ? trashPath : null;
  }

  /// Moves [trashFilePath] back to its original location under [libraryRoot].
  /// Returns the restored absolute path on success, null if the move failed.
  static Future<String?> restore(
      String trashFilePath, String libraryRoot) async {
    final relativeInTrash = trashFilePath.substring(libraryRoot.length + 1);
    final originalRelative =
        relativeInTrash.substring('${Keys.trashFolderName}/'.length);
    final originalPath = '$libraryRoot/$originalRelative';
    final moved = await _move(trashFilePath, originalPath);
    return moved ? originalPath : null;
  }

  /// Permanently deletes the file and its thumbnail from `.echotrash`.
  static Future<bool> permanentDelete(String trashFilePath) async {
    final file = File(trashFilePath);
    if (await file.exists()) {
      try {
        await file.delete();
      } catch (e, st) {
        dev.log(
          'Failed to delete file: $e',
          stackTrace: st,
          name: 'TrashService.permanentDelete',
        );
        return false;
      }
    }

    final thumb = File(ThumbnailService.pathFor(trashFilePath));
    if (await thumb.exists()) {
      try {
        await thumb.delete();
      } catch (e, st) {
        dev.log(
          'Failed to delete thumbnail: $e',
          stackTrace: st,
          name: 'TrashService.permanentDelete',
        );
      }
    }

    return true;
  }

  /// Returns true if the move succeeded, false otherwise.
  static Future<bool> _move(String from, String to) async {
    try {
      await Directory(to).parent.create(recursive: true);
      await File(from).rename(to);
      return true;
    } catch (e, st) {
      dev.log(
        'Failed to move file $from → $to: $e',
        stackTrace: st,
        name: 'TrashService._move',
      );
      return false;
    }
  }
}