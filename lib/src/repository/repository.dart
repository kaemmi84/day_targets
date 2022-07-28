import '../dao/dao.dart';
import '../helper/database_provider.dart';

abstract class Repository<T> {
  Dao<T> get dao;
  late DatabaseProvider databaseProvider;

  Future<T> insert(T object);

  Future<T> delete(T object);

  Future<T> update(T object);

  Future<List<T>> getAll() async {
    final db = await databaseProvider.db();
    var maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }

  Future<T> getOne(int id) async {
    final db = await databaseProvider.db();
    var maps = await db.query(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [id]);
    return dao.fromMap(maps.first);
  }
}