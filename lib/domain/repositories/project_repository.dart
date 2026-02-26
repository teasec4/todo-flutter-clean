import 'package:isar_test_todo/domain/entity/project_entity.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntity>> getAllProjects();
  Future<void> createProject(String name, [String? description]);
  Future<void> deleteProject(int id);
