import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:isar_test_todo/data/models/todo.dart';

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  List<Todo> getTodosByProject(String projectId) {
    return _todos.where((t) => t.projectId == projectId).toList();
  }

  void createTodo(String projectId, String title) {
    final todo = Todo(
      id: const Uuid().v4(),
      projectId: projectId,
      title: title,
      createdAt: DateTime.now(),
    );
    _todos.add(todo);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final todo = _todos[index];
      final newIsCompleted = !todo.isCompleted;
      _todos[index] = todo.copyWith(
        isCompleted: newIsCompleted,
        completedAt: newIsCompleted ? DateTime.now() : null,
      );
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void updateTodo(String id, String title) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(title: title);
      notifyListeners();
    }
  }

  void deleteProjectTodos(String projectId) {
    _todos.removeWhere((t) => t.projectId == projectId);
    notifyListeners();
  }
}
