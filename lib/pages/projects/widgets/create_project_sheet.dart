import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateProjectSheet extends StatefulWidget {
  final String? oldName;
  const CreateProjectSheet({super.key, this.oldName});

  @override
  State<CreateProjectSheet> createState() => _CreateProjectSheetState();
}

class _CreateProjectSheetState extends State<CreateProjectSheet> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  late FocusNode _nameFocus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _nameFocus = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("创建新项目"),
            const SizedBox(height: 20),
            TextField(
              focusNode: _nameFocus,
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: '项目名称',
                labelText: '名称',
                prefixIcon: Icon(Icons.folder),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              textInputAction: TextInputAction.done,
              maxLines: 3,
              minLines: 1,
              onSubmitted: (_) {
                if (_nameController.text.isNotEmpty) {
                  context.pop({
                    'name': _nameController.text,
                    'description': _descriptionController.text,
                  });
                }
              },
              decoration: const InputDecoration(
                hintText: '项目描述',
                labelText: '描述',
                prefixIcon: Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _nameController,
              builder: (context, value, child) {
                return Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
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
                                context.pop({
                                  'name': value.text,
                                  'description':
                                      _descriptionController.text,
                                });
                              },
                        child: const Text("提交"),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
