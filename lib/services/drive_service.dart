import 'dart:developer' as dev;
import 'dart:io';

class DriveService {
  static Future<String> volumeUuid(String path) async {
    if (Platform.isMacOS) {
      try {
        final result = await Process.run('diskutil', ['info', path]);
        if (result.exitCode == 0) {
          final match = RegExp(r'Volume UUID:\s+(\S+)')
              .firstMatch(result.stdout as String);
          if (match != null) return match.group(1)!;
        }
      } catch (e, st) {
        dev.log('diskutil info failed for $path: $e',
            stackTrace: st, name: 'DriveService.volumeUuid');
      }
    }
    return path.hashCode.abs().toRadixString(16).padLeft(8, '0');
  }

  static Future<String> volumeLabel(String path) async {
    if (Platform.isMacOS) {
      try {
        final result = await Process.run('diskutil', ['info', path]);
        if (result.exitCode == 0) {
          final match = RegExp(r'Volume Name:\s+(.+)')
              .firstMatch(result.stdout as String);
          if (match != null) return match.group(1)!.trim();
        }
      } catch (e, st) {
        dev.log('diskutil info failed for $path: $e',
            stackTrace: st, name: 'DriveService.volumeLabel');
      }
    }
    return path.split('/').last;
  }
}
