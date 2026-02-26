import 'package:flutter/foundation.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';
import 'package:isar_test_todo/domain/repositories/project_repository.dart';

class ProjectProvider with ChangeNotifier {
  final ProjectRepository _projectRepository;
  
  List<ProjectEntity> _projects = [];
  List<ProjectEntity> get projects => _projects;

  ProjectProvider(this._projectRepository);

  Future<void> loadProjects() async {
    _projects = await _projectRepository.getAllProjects();
    notifyListeners();
  }

  Future<void> createProject(String name, [String? description]) async {
    await _projectRepository.createProject(name, description);
    await loadProjects();
  }

  Future<void> deleteProject(int id) async {
    await _projectRepository.deleteProject(id);
    await loadProjects();
  }
}

// isar.projectEntitys.where().watch(fireImmediately: true);

// late final StreamSubscription _subscription;

// ProjectProvider(this._repository) {
//   _subscription = _repository.watchProjects().listen((data) {
//     _projects = data;
//     notifyListeners();
//   });
// }