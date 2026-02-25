import 'package:isar_test_todo/data/models/project.dart';

abstract class ProjectRepository {
  List<Project> get projects;
  void createProject(String name, [String? description]);
  void deleteProject(String id);
  void updateProject(String id, String name, [String? description]);
}
