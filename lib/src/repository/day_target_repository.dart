import '../dao/day_target_dao.dart';
import '../helper/database_provider.dart';
import '../model/day_target.dart';
import 'repository.dart';

class DayTargetRepository extends Repository<DayTarget> {
  String get columnDay => (dao as DayTargetDao).columnDay;
  String get columnTarget => (dao as DayTargetDao).columnTarget;
  @override
  get dao => DayTargetDao();


  @override
  DatabaseProvider databaseProvider;

  DayTargetRepository(this.databaseProvider);

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
        where: '$columnDay = ? AND $columnTarget = ?', whereArgs: [object.day.id, object.target.id]);
    return object;
  }

  @override
  Future<DayTarget> update(DayTarget object) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(object),
        where: '$columnDay = ? AND $columnTarget = ?', whereArgs: [object.day.id, object.target.id]);
    return object;
  }

  @override
  Future<List<DayTarget>> getAll() async {
    final db = await databaseProvider.db();
    var maps = await db.rawQuery('''
    SELECT 
      t.id AS targetId,
      t.description AS description,
      d.id AS dayId,
      d.date AS date,
      dt.isDone AS isDone 
    FROM
      targets t
      INNER JOIN dayTargets dt ON t.id = dt.target
      INNER JOIN days d ON dt.day = d.id
    ''');
    return dao.fromList(maps);
  }

  Future<DayTarget> getDayTarget(int targetId, int dayId) async {
    final db = await databaseProvider.db();
    var maps = await db.rawQuery('''
    SELECT 
      t.id AS targetId,
      t.description AS description,
      d.id AS dayId,
      d.date AS date,
      dt.isDone AS isDone 
    FROM
      targets t
      INNER JOIN dayTargets dt ON t.id = dt.target
      INNER JOIN days d ON dt.day = d.id
      WHERE t.id = ? AND d.id = ?
    ''', [targetId, dayId]);
    return dao.fromList(maps).first;
  }
}