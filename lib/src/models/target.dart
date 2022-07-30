class Target {
  int? id;
  final String description;

  Target(this.description, [this.id]);

  @override
  String toString() {
    return 'Target { id: $id, description: $description }';
  }
}