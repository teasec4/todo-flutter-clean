import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';

import 'package:isar_test_todo/domain/entity/todo_entity.dart';
import 'package:isar_test_todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final Isar isar;

  TodoRepositoryImpl(this.isar);

  @override
  Future<List<TodoEntity>> getAllTodosByProject(int projectId) async {
    return await isar.todoEntitys
        .filter()
        .projectIdEqualTo(projectId)
        .findAll();
  }

  @override
  Future<void> addTodo(int projectId, String title) async {
    final project = await isar.projectEntitys.get(projectId);
    // guard
    if (project == null) return;

    final todo = TodoEntity()
      ..title = title
      ..isCompleted = false
      ..createdAt = DateTime.now()
      ..projectId = projectId;

    await isar.writeTxn(() async {
      await isar.todoEntitys.put(todo);
      project.todos.add(todo);
      await project.todos.save();
      await isar.projectEntitys.put(project);
    });
  }

  @override
  Future<void> toggleTodo(int id) async {
    final todo = await isar.todoEntitys.get(id);
    if (todo == null) return;

    await isar.writeTxn(() async {
      todo.isCompleted = !todo.isCompleted;
      await isar.todoEntitys.put(todo);
    });
  }

  @override
  Future<void> deleteTodo(int id) async {
    final todo = await isar.todoEntitys.get(id);
    if (todo == null) return;

    final project = await isar.projectEntitys.get(todo.projectId);

    await isar.writeTxn(() async {
      await isar.todoEntitys.delete(id);
      
      if (project != null) {
        project.todos.remove(todo);
        await project.todos.save();
      }
    });
  }

  Stream<List<TodoEntity>> watchAllTodos() {
    return isar.todoEntitys.where().watch(fireImmediately: true);
  }

  Future<List<TodoEntity>> getCompleted() async {
    return await isar.todoEntitys.filter().isCompletedEqualTo(true).findAll();
  }
}
