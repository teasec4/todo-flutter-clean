import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/domain/entity/todo_entity.dart';

part 'project_entity.g.dart';

@collection
class ProjectEntity {
  Id id = Isar.autoIncrement;

  late String name;

  String? description;
  
  late DateTime createdAt;

  final todos = IsarLinks<TodoEntity>();
  
 
}
