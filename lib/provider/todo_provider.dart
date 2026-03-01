import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_test_todo/domain/entity/todo_entity.dart';
import 'package:isar_test_todo/provider/todo_repository_provider.dart';

/// Все todos
final allTodosProvider = FutureProvider.autoDispose<List<TodoEntity>>((ref) async {
  final repo = await ref.watch(todoRepositoryProvider.future);
  return await repo.getAllTodosByProject(-1); // -1 чтобы получить все
});

/// Todos для конкретного проекта
final todosByProjectProvider = FutureProvider.autoDispose.family<List<TodoEntity>, int>(
  (ref, projectId) async {
    final repo = await ref.watch(todoRepositoryProvider.future);
    return await repo.getAllTodosByProject(projectId);
  },
);

/// Создание todo
final createTodoProvider = FutureProvider.autoDispose.family<void, (int, String)>(
  (ref, args) async {
    final repo = await ref.watch(todoRepositoryProvider.future);
    await repo.addTodo(args.$1, args.$2);
  },
);

/// Переключение todo
final toggleTodoProvider = FutureProvider.autoDispose.family<void, int>(
  (ref, todoId) async {
    final repo = await ref.watch(todoRepositoryProvider.future);
    await repo.toggleTodo(todoId);
  },
);

/// Удаление todo
final deleteTodoProvider = FutureProvider.autoDispose.family<void, int>(
  (ref, todoId) async {
    final repo = await ref.watch(todoRepositoryProvider.future);
    await repo.deleteTodo(todoId);
  },
);
