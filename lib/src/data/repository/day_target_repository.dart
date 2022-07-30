import '../../models/day_target.dart';
import '../dao/day_target_dao.dart';
import 'repository.dart';

class DayTargetRepository extends Repository<DayTarget> {
  String get columnDate => (dao as DayTargetDao).columnDate;
  String get columnTarget => (dao as DayTargetDao).columnTarget;

  @override
  get dao => DayTargetDao();

  DayTargetRepository(databaseProvider): super(databaseProvider);

  @override
  Future<DayTarget> insert(DayTarget object) async {
    final db = await databaseProvider.db();
    await db.insert(dao.tableName, dao.toMap(object));
    return object;
  }

  @override
  Future<DayTarget> delete(DayTarget object) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: '$columnDate = ? AND $columnTarget = ?',
        whereArgs: [object.date.toIso8601String(), object.target.id]);
    return object;
  }

  @override
  Future<DayTarget> update(DayTarget object) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(object),
        where: '$columnDate = ? AND $columnTarget = ?',
        whereArgs: [object.date.toIso8601String(), object.target.id]);
    return object;
  }

  @override
  Future<List<DayTarget>> getAll() async {
    final db = await databaseProvider.db();
    var maps = await db.rawQuery('''
    SELECT 
      t.id AS targetId,
      t.description AS description,
      dt.date AS date,
      dt.isDone AS isDone 
    FROM
      targets t
      INNER JOIN dayTargets dt ON t.id = dt.target
    ''');
    return dao.fromList(maps);
  }

  Future<DayTarget> getDayTarget(int targetId, int dayId) async {
    final db = await databaseProvider.db();
    var maps = await db.rawQuery('''
    SELECT 
      t.id AS targetId,
      t.description AS description,
      dt.date AS date,
      dt.isDone AS isDone 
    FROM
      targets t
      INNER JOIN dayTargets dt ON t.id = dt.target
      WHERE t.id = ? AND d.id = ?
    ''', [targetId, dayId]);
    return dao.fromList(maps).first;
  }

  Future<List<DayTarget>> getDayTargetByTargetId(int targetId) async {
    final db = await databaseProvider.db();
    var maps = await db.rawQuery('''
    SELECT 
      t.id AS targetId,
      t.description AS description,
      dt.date AS date,
      dt.isDone AS isDone 
    FROM
      targets t
      INNER JOIN dayTargets dt ON t.id = dt.target
      WHERE t.id = ?
    ''', [targetId]);
    return dao.fromList(maps);
  }

  Future<int> deleteDayTargetByTargetId(int targetId) async {
    final db = await databaseProvider.db();
    await db.rawDelete('''
      DELETE FROM dayTargets
      WHERE target IN (
        SELECT id FROM targets WHERE id = ?
      );
    ''', [targetId]);
    return targetId;
  }
}