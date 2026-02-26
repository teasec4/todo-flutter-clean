import 'package:flutter/material.dart';
import 'package:isar_test_todo/domain/entity/todo_entity.dart';

class TodoTile extends StatelessWidget {
  final TodoEntity todo;
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

    return GestureDetector(
      onTap: onToggle,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted 
                ? scheme.outlineVariant
                : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
