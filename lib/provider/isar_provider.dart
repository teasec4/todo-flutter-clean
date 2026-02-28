import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';
import 'package:path_provider/path_provider.dart';

import '../domain/entity/todo_entity.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final List<CollectionSchema> schema = [ProjectEntitySchema, TodoEntitySchema];
  final isar = await Isar.open(
    schema,
    directory: dir.path);
    
  return isar;
});
