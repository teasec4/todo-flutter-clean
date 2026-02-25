import 'package:isar_test_todo/data/models/todo.dart';

abstract class TodoRepository {
  List<Todo> get todos;
  List<Todo> getTodosByProject(String projectId);
  void createTodo(String projectId, String title);
  void toggleTodo(String id);
  void deleteTodo(String id);
  void updateTodo(String id, String title);
  void deleteProjectTodos(String projectId);
}
