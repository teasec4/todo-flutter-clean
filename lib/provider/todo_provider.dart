import 'package:flutter/foundation.dart';
import 'package:isar_test_todo/domain/entity/todo_entity.dart';
import 'package:isar_test_todo/domain/repositories/todo_repository.dart';

class TodoProvider with ChangeNotifier {
  final TodoRepository _todoRepository;

  TodoProvider(this._todoRepository);

  List<TodoEntity> _todos = [];
  List<TodoEntity> get todos => _todos;

  Future<void> getAllTodosByProject(int projectId) async {
    _todos = await _todoRepository.getAllTodosByProject(projectId);
    notifyListeners();
  }

  Future<void> createTodo(int projectId, String title) async {
    await _todoRepository.addTodo(projectId, title);
    notifyListeners();
  }

  Future<void> toggleTodo(int id) async{
    await _todoRepository.toggleTodo(id);
    notifyListeners();
  }

  Future<void> deleteTodo(int id) async{
    await _todoRepository.deleteTodo(id);
    notifyListeners();
  }

}
