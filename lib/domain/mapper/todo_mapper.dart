import 'package:isar_test_todo/data/models/todo.dart';
import 'package:isar_test_todo/domain/entity/todo_entity.dart';

extension TodoMapper on TodoEntity {
  Todo toDomain() {
    return Todo(
      id: id,
      title: title,
      isCompleted: isCompleted,
      createdAt: createdAt,
    );
  }
}

extension TodoEntityMapper on Todo {
  TodoEntity toEntity() {
    return TodoEntity()
      ..id = id
      ..title = title
      ..isCompleted = isCompleted
      ..createdAt = createdAt;
  }
}
