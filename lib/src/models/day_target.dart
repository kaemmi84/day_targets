import 'day.dart';
import 'target.dart';

class DayTarget {
  final Day day;
  final Target target;
  bool isDone;

  DayTarget(this.day, this.target, { this.isDone = false });

  @override
  String toString() {
    return 'DayTarget { day: $day, target: $target, isDone: $isDone }';
  }
}