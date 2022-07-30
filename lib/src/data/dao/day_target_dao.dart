import '../../models/day_target.dart';
import '../../models/target.dart';
import 'dao.dart';

class DayTargetDao extends Dao<DayTarget> {
  final columnDate = 'date';
  final columnTarget = 'target';
  final _subColumnTargetId = 'targetId';
  final _subColumnTargetDescription = 'description';
  final _columnIsDone = 'isDone';

  @override
  String get columnId => '';

  @override
  String get tableName => 'dayTargets';

  @override
  String get createTableQuery =>
      '''CREATE TABLE $tableName(
          $columnDate STRING,
          $columnTarget INTEGER,
          $_columnIsDone INTEGER,
          PRIMARY KEY ($columnDate, $columnTarget))''';

  @override
  //need a joint function
  DayTarget fromMap(Map<String, dynamic> query) {
    return DayTarget(
      Target(
          query[_subColumnTargetDescription],
          query[_subColumnTargetId],
      ),
      DateTime.tryParse(query[columnDate]) ?? DateTime.now(),
      query[_columnIsDone] == 1
    );
  }

  @override
  Map<String, dynamic> toMap(DayTarget object) {
    return <String, dynamic>{
      columnDate: object.date.toIso8601String(),
      columnTarget: object.target.id,
      _columnIsDone: object.isDone ? 1 : 0,
    };
  }
}