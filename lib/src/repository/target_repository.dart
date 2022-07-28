import '../dao/target_dao.dart';
import '../helper/database_provider.dart';
import '../model/target.dart';
import 'repository.dart';

class TargetRepository extends Repository<Target> {
  @override
  get dao => TargetDao();

  @override
  DatabaseProvider databaseProvider;

  TargetRepository(this.databaseProvider);

  @override
  Future<Target> insert(Target object) async {
    final db = await databaseProvider.db();
    object.id = await db.insert(dao.tableName, dao.toMap(object));
    return object;
  }

  @override
  Future<Target> delete(Target object) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [object.id]);
    return object;
  }

  @override
  Future<Target> update(Target object) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(object),
        where: dao.columnId + " = ?", whereArgs: [object.id]);
    return object;
  }
}