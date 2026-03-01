import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_test_todo/provider/todo_provider.dart';
import 'package:isar_test_todo/provider/project_provider.dart';
import 'package:isar_test_todo/pages/todos/widgets/create_todo_sheet.dart';
import 'package:isar_test_todo/pages/todos/widgets/todo_tile.dart';

class TodosPage extends ConsumerWidget {
  final int projectId;

  const TodosPage({super.key, required this.projectId});

  Future<void> _showCreateTodo(BuildContext context, WidgetRef ref) async {
    final newTodoTitle = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => const CreateTodoSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    if (!context.mounted) return;

    if (newTodoTitle != null && newTodoTitle.isNotEmpty) {
      await ref.read(createTodoProvider((projectId, newTodoTitle)).future);
      ref.invalidate(todosByProjectProvider(projectId));
      ref.invalidate(allTodosProvider);
    }
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, int todoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除待办事项？'),
        content: const Text('此操作无法撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(deleteTodoProvider(todoId).future);
              ref.invalidate(todosByProjectProvider(projectId));
              ref.invalidate(allTodosProvider);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(allProjectsProvider);
    final todosAsync = ref.watch(todosByProjectProvider(projectId));

    return projectsAsync.when(
      data: (projects) {
        final project = projects.firstWhere(
          (p) => p.id == projectId,
          orElse: () => projects.isNotEmpty
              ? projects.first
              : throw StateError('No projects found'),
        );

        return todosAsync.when(
          data: (todos) {
            final incompleteTodos = todos.where((t) => !t.isCompleted).toList();
            final completedTodos = todos.where((t) => t.isCompleted).toList();

            return Scaffold(
              appBar: AppBar(title: Text(project.name), toolbarHeight: 64),
              body: todos.isEmpty
                  ? _emptyView()
                  : Column(
                      children: [
                        // Не сделанные
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 12),
                                child: Text(
                                  '待办事项 (${incompleteTodos.length})',
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: incompleteTodos.length,
                                  itemBuilder: (context, index) {
                                    final todo = incompleteTodos[index];
                                    return TodoTile(
                                      todo: todo,
                                      onToggle: () async {
                                        await ref.read(toggleTodoProvider(todo.id).future);
                                        ref.invalidate(todosByProjectProvider(projectId));
                                        ref.invalidate(allTodosProvider);
                                      },
                                      onLongPress: () {
                                        _showDeleteConfirmation(context, ref, todo.id);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Сделанные
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 12),
                                child: Text(
                                  '已完成 (${completedTodos.length})',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.outlineVariant,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: completedTodos.length,
                                  itemBuilder: (context, index) {
                                    final todo = completedTodos[index];
                                    return TodoTile(
                                      todo: todo,
                                      onToggle: () async {
                                        await ref.read(toggleTodoProvider(todo.id).future);
                                        ref.invalidate(todosByProjectProvider(projectId));
                                        ref.invalidate(allTodosProvider);
                                      },
                                      onLongPress: () {
                                        _showDeleteConfirmation(context, ref, todo.id);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _showCreateTodo(context, ref),
                child: const Icon(Icons.add),
              ),
            );
          },
          loading: () => Scaffold(
            appBar: AppBar(title: const Text('Loading...'), toolbarHeight: 64),
            body: const Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) => Scaffold(
            appBar: AppBar(title: const Text('Error'), toolbarHeight: 64),
            body: Center(child: Text('Error: $err')),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Loading...'), toolbarHeight: 64),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(title: const Text('Error'), toolbarHeight: 64),
        body: Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _emptyView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text("还没有待办事项", style: TextStyle(fontSize: 16, color: Colors.grey)),
          Text(
            "添加你的第一个待办事项来开始",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
