import 'target.dart';

class DayTarget {
  final Target target;
  final DateTime date;
  bool isDone;

  DayTarget(this.target, this.date, [ this.isDone = false ]);

  @override
  String toString() {
    return 'DayTarget { date: ${date.toIso8601String()}, target: $target, isDone: $isDone }';
  }
}