import 'package:flutter/material.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';

class ProjectTile extends StatelessWidget {
  final ProjectEntity project;
  final VoidCallback onTap;
  final VoidCallback onLongPress;



  const ProjectTile({
    super.key,
    required this.project,
    required this.onTap,
    required this.onLongPress,


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
        
      ),
    );
  }
}
