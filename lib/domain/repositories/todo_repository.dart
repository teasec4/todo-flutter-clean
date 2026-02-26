import 'package:isar_test_todo/domain/entity/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getAllTodosByProject(int projectId);
  Stream<List<TodoEntity>> watchTodosByProject(int projectId);
  Stream<List<TodoEntity>> watchAllTodos();
  Future<void> addTodo(int projectId, String title);
  Future<void> deleteTodo(int id);
  Future<void> toggleTodo(int id);
}
