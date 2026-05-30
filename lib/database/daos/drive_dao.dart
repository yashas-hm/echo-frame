import 'package:drift/drift.dart';
import 'package:echo_frame/database/database.dart';

class DriveDao {
  const DriveDao(this._db);

  final EchoDatabase _db;

  Future<void> upsertDrive({
    required String uuid,
    required String label,
    required String mountPath,
  }) async {
    await _db.into(_db.driveRecords).insertOnConflictUpdate(
          DriveRecordsCompanion.insert(
            uuid: uuid,
            label: label,
            lastMountPath: Value(mountPath),
            firstIndexedAt: DateTime.now().toUtc(),
            isOnline: const Value(true),
          ),
        );
  }
}
