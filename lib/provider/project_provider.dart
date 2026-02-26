import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';
import 'package:isar_test_todo/domain/repositories/project_repository.dart';

class ProjectProvider with ChangeNotifier {
  final ProjectRepository _projectRepository;
  
  List<ProjectEntity> _projects = [];
  List<ProjectEntity> get projects => _projects;

  late StreamSubscription<List<ProjectEntity>> _projectsSubscription;

  ProjectProvider(this._projectRepository) {
    _projectsSubscription = _projectRepository.watchProjects().listen((projects) {
      _projects = projects;
      notifyListeners();
    });
  }

  Future<void> createProject(String name, [String? description]) async {
    await _projectRepository.createProject(name, description);
  }

  Future<void> deleteProject(int id) async {
    await _projectRepository.deleteProject(id);
  }

  @override
  void dispose() {
    _projectsSubscription.cancel();
    super.dispose();
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