import 'dart:developer' as dev;
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/database/schemas/media_schema.dart';
import 'package:echo_frame/database/schemas/media_tag_schema.dart';
import 'package:echo_frame/database/schemas/tag_schema.dart';

part 'database.g.dart';

@DriftDatabase(tables: [MediaRecords, TagRecords, MediaTagRecords])
class EchoDatabase extends _$EchoDatabase {
  EchoDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_media_year_month '
            'ON media_records (captured_year, captured_month)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_media_captured_at '
            'ON media_records (captured_at)',
          );
        },
      );

  // ── Singleton ──────────────────────────────────────────────────────────────

  static EchoDatabase? _instance;

  static EchoDatabase get instance {
    assert(_instance != null, 'EchoDatabase.open() must be called before use');
    return _instance!;
  }

  static bool get isOpen => _instance != null;

  static String echoframeDir(String libraryRoot) => '$libraryRoot/.echoframe';

  static Future<EchoDBOpenResult> open(String libraryRoot) async {
    bool isExisting = false;
    bool success = false;
    try {
      final dir = Directory(echoframeDir(libraryRoot));
      isExisting = await dir.exists();
      if (!isExisting) await dir.create(recursive: true);
      final file = File('${dir.path}/${Keys.dbFileName}');
      _instance = EchoDatabase(NativeDatabase.createInBackground(file));
      success = true;
    } catch (e, st) {
      dev.log(
        'Failed to open database at $libraryRoot: $e',
        stackTrace: st,
        name: 'EchoDatabase.open',
      );
    }

    return EchoDBOpenResult(success: success, isExisting: isExisting);
  }

  static Future<void> closeDb() async {
    await _instance?.close();
    _instance = null;
  }
}

class EchoDBOpenResult {
  final bool success;
  final bool isExisting;

  EchoDBOpenResult({
    required this.success,
    this.isExisting = false,
  });
}
