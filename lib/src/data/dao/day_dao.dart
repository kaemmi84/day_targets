import '../../models/day.dart';
import 'dao.dart';

class DayDao extends Dao<Day> {
  final _columnDate = 'date';

  @override
  String get columnId => 'id';

  @override
  String get tableName => 'days';

  @override
  String get createTableQuery =>
      '''CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_columnDate TEXT)''';

  @override
  Day fromMap(Map<String, dynamic> query) {
    return Day(
      query[columnId],
      DateTime.tryParse(query[_columnDate]) ?? DateTime.now()
    );
  }

  @override
  Map<String, dynamic> toMap(Day object) {
    return <String, dynamic>{
      columnId: object.id,
      _columnDate: object.date.toIso8601String(),
    };
  }
}