import '../../models/day.dart';
import '../../models/day_target.dart';
import '../../models/target.dart';
import 'dao.dart';

class DayTargetDao extends Dao<DayTarget> {
  final columnDay = 'day';
  final columnTarget = 'target';
  final _subColumnTargetId = 'targetId';
  final _subColumnTargetDescription = 'description';
  final _subColumnDayId = 'dayId';
  final _subColumnDayDate = 'date';
  final _columnIsDone = 'isDone';

  @override
  String get columnId => '';

  @override
  String get tableName => 'dayTargets';

  @override
  String get createTableQuery =>
      '''CREATE TABLE $tableName(
          $columnDay INTEGER,
          $columnTarget INTEGER,
          $_columnIsDone INTEGER,
          PRIMARY KEY ($columnDay, $columnTarget))''';

  @override
  //need a joint function
  DayTarget fromMap(Map<String, dynamic> query) {
    return DayTarget(
      Day(
          query[_subColumnDayId],
          DateTime.tryParse(query[_subColumnDayDate]) ?? DateTime.now()
      ),
      Target(
          query[_subColumnTargetId],
          query[_subColumnTargetDescription]
      ),
      isDone: query[_columnIsDone] == 1
    );
  }

  @override
  Map<String, dynamic> toMap(DayTarget object) {
    return <String, dynamic>{
      columnDay: object.day.id,
      columnTarget: object.target.id,
      _columnIsDone: object.isDone ? 1 : 0,
    };
  }
}