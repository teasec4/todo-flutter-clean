import 'package:isar_test_todo/data/repository/todo_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_test_todo/provider/isar_provider.dart';

final todoRepositoryProvider = FutureProvider.autoDispose((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return TodoRepositoryImpl(isar);
});
