import 'package:isar_test_todo/data/models/todo.dart';
import 'package:isar_test_todo/domain/repositories/todo_repository.dart';
import 'package:uuid/uuid.dart';

class TodoRepositoryImpl implements TodoRepository {
  final List<Todo> _todos = [];

  @override
  List<Todo> get todos => _todos;

  @override
  void createTodo(String projectId, String title) {
    final todo = Todo(
      id: const Uuid().v4(),
      projectId: projectId,
      title: title,
      createdAt: DateTime.now(),
    );
    _todos.add(todo);
  }

  @override
  void toggleTodo(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(
        isCompleted: !todo.isCompleted,
      );
    }
  }

  @override
  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
  }

  @override
  void updateTodo(String id, String title) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(title: title);
    }
  }

  @override
  void deleteProjectTodos(String projectId) {
    _todos.removeWhere((t) => t.projectId == projectId);
  }

  @override
  List<Todo> getTodosByProject(String projectId) {
    return _todos.where((t) => t.projectId == projectId).toList();
  }
}
