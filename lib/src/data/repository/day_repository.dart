import '../../models/day.dart';
import '../dao/day_dao.dart';
import 'repository.dart';

class DayRepository extends Repository<Day> {
  @override
  get dao => DayDao();

  DayRepository(databaseProvider): super(databaseProvider);

  @override
  Future<Day> insert(Day object) async {
    final db = await databaseProvider.db();
    object.id = await db.insert(dao.tableName, dao.toMap(object));
    return object;
  }

  @override
  Future<Day> delete(Day object) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [object.id]);
    return object;
  }

  @override
  Future<Day> update(Day object) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(object),
        where: dao.columnId + " = ?", whereArgs: [object.id]);
    return object;
  }

  Future<Day> getById(int id) async {
    final db = await databaseProvider.db();
    var maps = await db.query(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [id]);
    return dao.fromMap(maps.first);
  }
}