import 'package:flutter/material.dart';
import 'package:isar_test_todo/core/di/service_locator.dart';
import 'package:provider/provider.dart';
import 'package:isar_test_todo/provider/todo_provider.dart';
import 'package:isar_test_todo/provider/project_provider.dart';
import 'package:isar_test_todo/pages/todos/widgets/create_todo_sheet.dart';
import 'package:isar_test_todo/pages/todos/widgets/todo_tile.dart';

class TodosPage extends StatelessWidget {
  final int projectId;

  const TodosPage({super.key, required this.projectId});

  Future<void> _showCreateTodo(BuildContext context) async {
    final newTodoTitle = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => const CreateTodoSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    if (!context.mounted) return;

    if (newTodoTitle != null && newTodoTitle.isNotEmpty) {
      await getIt<TodoProvider>().createTodo(projectId, newTodoTitle);
    }
  }

  void _showDeleteConfirmation(BuildContext context, int todoId) {
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
            onPressed: () {
              getIt<TodoProvider>().deleteTodo(todoId);
              Navigator.pop(context);
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
  Widget build(BuildContext context) {
    final projectProvider = context.watch<ProjectProvider>();
    final project = projectProvider.projects.firstWhere(
      (p) => p.id == projectId,
      orElse: () => projectProvider.projects.isEmpty 
          ? throw StateError('No projects found')
          : projectProvider.projects.first,
    );

    final todoProvider = context.watch<TodoProvider>();
    final todos = todoProvider.getTodosByProject(projectId);
    
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
                              onToggle: () {
                                todoProvider.toggleTodo(todo.id);
                              },
                              onLongPress: () {
                                _showDeleteConfirmation(context, todo.id);
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
                              onToggle: () {
                                todoProvider.toggleTodo(todo.id);
                              },
                              onLongPress: () {
                                _showDeleteConfirmation(context, todo.id);
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
        onPressed: () => _showCreateTodo(context),
        child: const Icon(Icons.add),
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
