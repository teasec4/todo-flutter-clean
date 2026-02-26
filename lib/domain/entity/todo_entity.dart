import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';

part 'todo_entity.g.dart';

@collection
class TodoEntity {
  Id id = Isar.autoIncrement;

  late String title;

  late bool isCompleted;

  late DateTime createdAt;
  
  final project = IsarLink<ProjectEntity>();

}
