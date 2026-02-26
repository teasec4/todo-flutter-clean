import 'package:isar_test_todo/domain/entity/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getAllTodos();
  // List<Todo> getTodosByProject(String projectId);
  Future<void> addTodo(int projectId, String title);
  Future<void> deleteTodo(int id);
  Future<void> toggleTodo(int id);
    
}
