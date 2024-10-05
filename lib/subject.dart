class Subject {
  final int id;
  final String name;
  final int timeSpent; // Time spent in minutes

  Subject({required this.id, required this.name, this.timeSpent = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'timeSpent': timeSpent,
    };
  }
}
