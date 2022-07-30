
import '../../models/target.dart';
import 'dao.dart';

class TargetDao extends Dao<Target> {
  final _columnDescription = 'description';

  @override
  String get columnId => 'id';

  @override
  String get tableName => 'targets';

  @override
  String get createTableQuery =>
      '''CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_columnDescription TEXT)''';

  @override
  Target fromMap(Map<String, dynamic> query) {
    return Target(
        query[_columnDescription],
        query[columnId],
    );
  }

  @override
  Map<String, dynamic> toMap(Target object) {
    return <String, dynamic>{
      columnId: object.id,
      _columnDescription: object.description,
    };
  }
}