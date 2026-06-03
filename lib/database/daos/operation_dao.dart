import 'package:drift/drift.dart';
import 'package:echo_frame/database/database.dart';

class OperationDao {
  const OperationDao(this._db);

  final EchoDatabase _db;

  Future<void> insert(OperationRecordsCompanion companion) =>
      _db.into(_db.operationRecords).insert(companion);

  Future<List<OperationRecord>> getByBatchId(String batchId) =>
      (_db.select(_db.operationRecords)
            ..where((r) => r.batchId.equals(batchId))
            ..orderBy([(r) => OrderingTerm(expression: r.id)]))
          .get();

  Future<void> markRolledBack(String batchId) async {
    final now = DateTime.now().toUtc();
    await (_db.update(_db.operationRecords)
          ..where((r) => r.batchId.equals(batchId) & r.rolledBackAt.isNull()))
        .write(OperationRecordsCompanion(rolledBackAt: Value(now)));
  }
}
