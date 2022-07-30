import '../models/day_target.dart';

class ShownDayTarget extends DayTarget {
  bool editing;
  ShownDayTarget(day, target, isDone, [this.editing = false]): super(day, target);

  @override
  String toString() {
    return 'SHOWN DayTarget { day: $day, target: $target, isDone: $isDone, editing: $editing }';
  }
}