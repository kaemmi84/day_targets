class Target {
  int? id;
  final String description;

  Target(
    this.id,
    this.description
  );

  @override
  String toString() {
    return 'Target { id: $id, description: $description }';
  }
}