import 'package:isar_test_todo/domain/entity/project_entity.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntity>> getAllProjects();
  Stream<List<ProjectEntity>> watchProjects();
  Future<void> createProject(String name, [String? description]);
  Future<void> deleteProject(int id);
}
