import 'package:flutter/foundation.dart';
import 'package:isar_test_todo/data/repository/project_repository_impl.dart';
import 'package:isar_test_todo/domain/repositories/project_repository.dart';
import 'package:isar_test_todo/data/models/project.dart';

class ProjectProvider with ChangeNotifier {
  final ProjectRepository _projectRepository = ProjectRepositoryImpl();
  late List<Project> _projects;

  ProjectProvider() {
    _projects = _projectRepository.projects;
  }

  List<Project> get projects => _projects;

  void createProject(String name, [String? description]) {
    _projectRepository.createProject(name, description);
    notifyListeners();
  }

  void deleteProject(String id) {
    _projectRepository.deleteProject(id);
    notifyListeners();
  }

  void updateProject(String id, String name, [String? description]) {
    _projectRepository.updateProject(id, name, description);
    notifyListeners();
  }
}
