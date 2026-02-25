import 'package:isar_test_todo/data/models/project.dart';
import 'package:isar_test_todo/domain/repositories/project_repository.dart';
import 'package:uuid/uuid.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final List<Project> _projects = [];

  @override
  List<Project> get projects => _projects;
  
  @override
  void createProject(String name, [String? description]) {
    final project = Project(
      id: const Uuid().v4(),
      name: name,
      description: description,
      createdAt: DateTime.now(),
    );
    _projects.add(project);
  }
    
  @override
  void deleteProject(String id) {
   _projects.removeWhere((p) => p.id == id);
  }
  
  @override
  void updateProject(String id, String name, [String? description]) {
    final index = _projects.indexWhere((p) => p.id == id);
    if (index != -1) {
      _projects[index] = _projects[index].copyWith(
        name: name,
        description: description,
      );
    }
  }
}
