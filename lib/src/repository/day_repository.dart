import '../dao/dao.dart';
import '../dao/day_dao.dart';
import '../helper/database_provider.dart';
import '../model/day.dart';
import 'repository.dart';

class DayRepository extends Repository<Day> {
  @override
  get dao => DayDao();

  @override
  DatabaseProvider databaseProvider;

  DayRepository(this.databaseProvider);

  @override
  Future<Day> insert(Day day) async {
    final db = await databaseProvider.db();
    day.id = await db.insert(dao.tableName, dao.toMap(day));
    return day;
  }

  @override
  Future<Day> delete(Day day) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [day.id]);
    return day;
  }

  @override
  Future<Day> update(Day day) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(day),
        where: dao.columnId + " = ?", whereArgs: [day.id]);
    return day;
  }

  Future<Day> getById(int id) async {
    final db = await databaseProvider.db();
    var maps = await db.query(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [id]);
    return dao.fromMap(maps.first);
  }
}