class Day {
  int? id;
  final DateTime date;

  Day(
    this.id,
    this.date
  );

  @override
  String toString() {
    return 'Day { id: $id, date: ${date.toIso8601String()} }';
  }
}