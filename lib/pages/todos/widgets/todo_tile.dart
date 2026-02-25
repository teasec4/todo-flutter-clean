import 'package:flutter/material.dart';
import 'package:isar_test_todo/data/models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onLongPress;

  const TodoTile({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      key: ObjectKey(todo),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onLongPress: onLongPress,
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? scheme.onSurfaceVariant : scheme.onSurface,
          ),
        ),
        subtitle: todo.completedAt != null
            ? Text(
                'Completed at ${todo.completedAt!.hour}:${todo.completedAt!.minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 12,
                  color: scheme.onSurfaceVariant,
                ),
              )
            : null,
      ),
    );
  }
}
