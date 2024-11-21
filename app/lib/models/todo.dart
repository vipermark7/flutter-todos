class TodoModel {
  int? id;
  String title;
  String description;
  DateTime createdAt;

  TodoModel(
      {this.id,
      required this.title,
      this.description = '',
      DateTime? createdAt})
      : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
