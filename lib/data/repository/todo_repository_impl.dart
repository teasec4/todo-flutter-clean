import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';

import 'package:isar_test_todo/domain/entity/todo_entity.dart';
import 'package:isar_test_todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final Isar _isar;

  TodoRepositoryImpl(this._isar);

  @override
  Future<List<TodoEntity>> getAllTodos() async {
    return await _isar.todoEntitys.where().findAll();
  }

  @override
  Future<void> addTodo(int projectId, String title) async {
    final project = await _isar.projectEntitys.get(projectId);
    // guard
    if (project == null) return;
    
    final todo = TodoEntity()
      ..title = title
      ..isCompleted = false
      ..createdAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.todoEntitys.put(todo);

      project.todos.add(todo);
      await project.todos.save();
    });
  }

  @override
  Future<void> toggleTodo(int id) async {
    final todo = await _isar.todoEntitys.get(id);
    if (todo == null) return;

    await _isar.writeTxn(() async {
      todo.isCompleted = !todo.isCompleted;
      await _isar.todoEntitys.put(todo);
    });
  }

  @override
  Future<void> deleteTodo(int id) async {
    await _isar.writeTxn(() async {
      await _isar.todoEntitys.delete(id);
    });
  }

  // not sure we need it
  Stream<List<TodoEntity>> watchTodos() {
    return _isar.todoEntitys.where().watch(fireImmediately: true);
  }

  // StreamBuilder(
  //   stream: repository.watchTodos(),
  //   builder: ...
  // )
  //
  Future<List<TodoEntity>> getCompleted() async {
    return await _isar.todoEntitys.filter().isCompletedEqualTo(true).findAll();
  }
}
