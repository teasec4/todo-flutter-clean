import 'package:flutter/foundation.dart';
import 'package:isar_test_todo/models/project.dart';

class ProjectProvider with ChangeNotifier {
  final List<Project> _projects = [];

  List<Project> get projects => _projects;

  void createProject(String name, [String? description]) {
    final project = Project(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      createdAt: DateTime.now(),
    );
    _projects.add(project);
    notifyListeners();
  }

  void deleteProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void updateProject(String id, String name, [String? description]) {
    final index = _projects.indexWhere((p) => p.id == id);
    if (index != -1) {
      _projects[index] = _projects[index].copyWith(
        name: name,
        description: description,
      );
      notifyListeners();
    }
  }
}
