import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_test_todo/provider/project_provider.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectProvider>().projects;
    return Scaffold(
      appBar: AppBar(title: Text("Projects")),
      body: projects.isEmpty
          ? _emptyView()
          : ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ListTile(
                  title: Text(project.name),
                  onTap: () {
                    context.go('/${project.id}/todos');
                  },
                );
              },
            ),
    );
  }

  Widget _emptyView() {
    return Center(
      child: Text("Empty Folder"),
    );
  }
}
