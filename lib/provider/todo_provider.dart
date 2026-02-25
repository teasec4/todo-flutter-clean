import 'package:flutter/foundation.dart';
import 'package:isar_test_todo/data/repository/todo_repository_impl.dart';
import 'package:isar_test_todo/domain/repositories/todo_repository.dart';
import 'package:isar_test_todo/data/models/todo.dart';

class TodoProvider with ChangeNotifier {
  final TodoRepository _todoRepository = TodoRepositoryImpl();

  List<Todo> get todos => _todoRepository.todos;

  List<Todo> getTodosByProject(String projectId) {
    return _todoRepository.getTodosByProject(projectId);
  }

  void createTodo(String projectId, String title) {
    _todoRepository.createTodo(projectId, title);
    notifyListeners();
  }

  void toggleTodo(String id) {
    _todoRepository.toggleTodo(id);
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todoRepository.deleteTodo(id);
    notifyListeners();
  }

  void updateTodo(String id, String title) {
    _todoRepository.updateTodo(id, title);
    notifyListeners();
  }

  void deleteProjectTodos(String projectId) {
    _todoRepository.deleteProjectTodos(projectId);
    notifyListeners();
  }
}
