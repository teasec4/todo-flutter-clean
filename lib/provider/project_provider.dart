import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';
import 'package:isar_test_todo/provider/project_repository_provider.dart';

/// Все проекты
final allProjectsProvider = FutureProvider.autoDispose<List<ProjectEntity>>((ref) async {
  final repo = await ref.watch(projectRepositoryProvider.future);
  return await repo.getAllProjects();
});

/// Создание проекта
final createProjectProvider = FutureProvider.autoDispose.family<void, (String, String?)>(
  (ref, args) async {
    final repo = await ref.watch(projectRepositoryProvider.future);
    await repo.createProject(args.$1, args.$2);
  },
);

/// Удаление проекта
final deleteProjectProvider = FutureProvider.autoDispose.family<void, int>(
  (ref, projectId) async {
    final repo = await ref.watch(projectRepositoryProvider.future);
    await repo.deleteProject(projectId);
  },
);
