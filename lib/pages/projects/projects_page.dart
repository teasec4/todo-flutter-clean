import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_test_todo/pages/projects/widgets/create_project_sheet.dart';
import 'package:isar_test_todo/pages/projects/widgets/project_tile.dart';
import 'package:isar_test_todo/provider/project_provider.dart';


class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  Future<void> _showCreateProject(BuildContext context, WidgetRef ref) async {
    final newProject = await showModalBottomSheet<Map<String, String>?>(
      context: context,
      builder: (context) => const CreateProjectSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    if (!context.mounted) return;

    if (newProject != null) {
      final String name = newProject['name'] ?? "";
      final String desc = newProject['description'] ?? '';

      await ref.read(
        createProjectProvider((name, desc)).future,
      );
      ref.invalidate(allProjectsProvider);
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    int projectId,
  ) {
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
            onPressed: () async {
              await ref.read(deleteProjectProvider(projectId).future);
              ref.invalidate(allProjectsProvider);
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
    final projects = ref.watch(allProjectsProvider);

    return projects.when(
      data: (projects) {
        return Scaffold(
          appBar: AppBar(title: const Text("项目"), toolbarHeight: 64),
          body: projects.isEmpty
              ? _emptyView()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];

                    return ProjectTile(
                      project: project,
                      onTap: () {
                        context.go('/${project.id}/todos');
                      },
                      onLongPress: () {
                        _showDeleteConfirmation(context, ref, project.id);
                      },
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showCreateProject(context, ref),
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
