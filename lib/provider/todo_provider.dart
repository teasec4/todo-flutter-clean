import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:isar_test_todo/domain/entity/todo_entity.dart';
import 'package:isar_test_todo/domain/repositories/todo_repository.dart';

class TodoProvider with ChangeNotifier {
  final TodoRepository _todoRepository;

  TodoProvider(this._todoRepository) {
    _allTodosSubscription = _todoRepository.watchAllTodos().listen((todos) {
      _allTodos = todos;
      notifyListeners();
    });
  }

  List<TodoEntity> _allTodos = [];
  List<TodoEntity> get allTodos => _allTodos;

  late StreamSubscription<List<TodoEntity>> _allTodosSubscription;

  List<TodoEntity> getTodosByProject(int projectId) {
    return _allTodos.where((t) => t.projectId == projectId).toList();
  }

  Future<void> createTodo(int projectId, String title) async {
    await _todoRepository.addTodo(projectId, title);
  }

  Future<void> toggleTodo(int id) async {
    await _todoRepository.toggleTodo(id);
  }

  Future<void> deleteTodo(int id) async {
    await _todoRepository.deleteTodo(id);
  }

  @override
  void dispose() {
    _allTodosSubscription.cancel();
    super.dispose();
  }
}
