import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_test_todo/data/repository/project_repository_impl.dart';
import 'package:isar_test_todo/provider/isar_provider.dart';

final projectProvider = FutureProvider((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return ProjectRepositoryImpl(isar: isar);
});
