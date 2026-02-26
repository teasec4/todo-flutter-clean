import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateTodoSheet extends StatefulWidget {
  const CreateTodoSheet({super.key});

  @override
  State<CreateTodoSheet> createState() => _CreateTodoSheetState();
}

class _CreateTodoSheetState extends State<CreateTodoSheet> {
  late TextEditingController _titleController;
  late FocusNode _titleFocus;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _titleFocus = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "创建新待办事项",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              TextField(
                focusNode: _titleFocus,
                controller: _titleController,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (_titleController.text.isNotEmpty) {
                    context.pop(_titleController.text);
                  }
                },
                decoration: const InputDecoration(
                  hintText: '需要做什么？',
                  labelText: '待办事项标题',
                  prefixIcon: Icon(Icons.check_circle_outline),
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _titleController,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            foregroundColor:
                                Theme.of(context).colorScheme.onSurface,
                          ),
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text("取消"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: value.text.isEmpty
                              ? null
                              : () {
                                  context.pop(value.text);
                                },
                          child: const Text("添加待办事项"),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      );
      }
      }
