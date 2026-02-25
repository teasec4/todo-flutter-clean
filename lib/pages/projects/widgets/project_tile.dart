import 'package:flutter/material.dart';
import 'package:isar_test_todo/data/models/project.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final int totalTodos;
  final int completedTodos;

  const ProjectTile({
    super.key,
    required this.project,
    required this.onTap,
    required this.onLongPress,
    required this.totalTodos,
    required this.completedTodos,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.folder, color: scheme.onPrimaryContainer),
        ),
        title: Text(
          project.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: project.description != null && project.description!.isNotEmpty
            ? Text(
                project.description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$completedTodos/$totalTodos',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
            Text(
              '已完成',
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
