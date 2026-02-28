import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';
import 'package:isar_test_todo/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Isar isar;

  ProjectRepositoryImpl({required this.isar});

  @override
  Future<List<ProjectEntity>> getAllProjects() async {
    return await isar.projectEntitys.where().findAll();
  }

  @override
  Future<void> createProject(String name, [String? description]) async {
    final project = ProjectEntity()
      ..name = name
      ..description = description
      ..createdAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.projectEntitys.put(project);
    });
  }

  @override
  Future<void> deleteProject(int id) async {
    await isar.writeTxn(() async {
      await isar.projectEntitys.delete(id);
    });
  }

  @override
  Stream<List<ProjectEntity>> watchProjects() {
    return isar.projectEntitys.where().watch(fireImmediately: true);
  }
}
