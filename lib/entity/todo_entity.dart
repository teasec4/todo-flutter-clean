import 'package:isar_community/isar.dart';

part 'todo_entity.g.dart';

@collection
class TodoEntity {
  Id id = Isar.autoIncrement;

  late String title;

  late bool isCompleted;

  late DateTime createdAt;

  DateTime? completedAt;
}
