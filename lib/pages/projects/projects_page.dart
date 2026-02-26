import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_test_todo/pages/projects/widgets/create_project_sheet.dart';
import 'package:isar_test_todo/pages/projects/widgets/project_tile.dart';
import 'package:isar_test_todo/provider/project_provider.dart';
import 'package:isar_test_todo/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  Future<void> _showCreateProject(BuildContext context) async {
    final newProject = await showModalBottomSheet<Map<String, String>?>(
      context: context,
      builder: (context) => const CreateProjectSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    if (!context.mounted) return;

    if (newProject != null) {
      context.read<ProjectProvider>().createProject(
        newProject['name'] ?? '',
        newProject['description'],
      );
    }
  }

  void _showDeleteConfirmation(BuildContext context, int projectId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除项目？'),
        content: const Text('此操作无法撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              context.read<ProjectProvider>().deleteProject(projectId);

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
    final projects = context.watch<ProjectProvider>().projects;
    return Scaffold(
      appBar: AppBar(title: const Text("项目"), toolbarHeight: 64),
      body: projects.isEmpty
          ? _emptyView()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                context.watch<TodoProvider>().getAllTodosByProject(project.id);
                final projectTodos = context.watch<TodoProvider>().todos;
                
                final completedCount = projectTodos
                    .where((t) => t.isCompleted)
                    .length;

                return ProjectTile(
                  project: project,
                  onTap: () {
                    context.go('/${project.id}/todos');
                  },
                  onLongPress: () {
                    _showDeleteConfirmation(context, project.id);
                  },
                  totalTodos: projectTodos.length,
                  completedTodos: completedCount,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateProject(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _emptyView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text("还没有项目", style: TextStyle(fontSize: 16, color: Colors.grey)),
          Text(
            "创建一个新项目来开始",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
