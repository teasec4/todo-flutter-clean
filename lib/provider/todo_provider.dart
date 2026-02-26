import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:isar_test_todo/domain/entity/todo_entity.dart';
import 'package:isar_test_todo/domain/repositories/todo_repository.dart';

class TodoProvider with ChangeNotifier {
  final TodoRepository _todoRepository;

  TodoProvider(this._todoRepository);

  List<TodoEntity> _todos = [];
  List<TodoEntity> get todos => _todos;

  StreamSubscription<List<TodoEntity>>? _todosSubscription;

  void watchTodosByProject(int projectId) {
    _todosSubscription?.cancel();
    _todosSubscription = _todoRepository.watchTodosByProject(projectId).listen((todos) {
      _todos = todos;
      notifyListeners();
    });
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
    _todosSubscription?.cancel();
    super.dispose();
  }
}
