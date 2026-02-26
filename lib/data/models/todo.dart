
class Todo {
  final int id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
  });

  // Todo copyWith({
  //   int? id,
  //   int? projectId,
  //   String? title,
  //   bool? isCompleted,
  //   DateTime? createdAt,
  // }) {
  //   return Todo(
  //     id: id ?? this.id,
  //     projectId: projectId ?? this.projectId,
  //     title: title ?? this.title,
  //     isCompleted: isCompleted ?? this.isCompleted,
  //     createdAt: createdAt ?? this.createdAt,
  //   );
  // }
}


