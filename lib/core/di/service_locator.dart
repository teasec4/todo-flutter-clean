import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/data/repository/project_repository_impl.dart';
import 'package:isar_test_todo/data/repository/todo_repository_impl.dart';
import 'package:isar_test_todo/domain/repositories/project_repository.dart';
import 'package:isar_test_todo/domain/repositories/todo_repository.dart';
import 'package:isar_test_todo/provider/project_provider.dart';
import 'package:isar_test_todo/provider/todo_provider.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator(Isar isar) async {
  // Register Isar database
  getIt.registerSingleton<Isar>(isar);

  // Register repositories
  getIt.registerSingleton<ProjectRepository>(
    ProjectRepositoryImpl(isar: isar),
  );

  getIt.registerSingleton<TodoRepository>(
    TodoRepositoryImpl(isar),
  );

  // Register providers
  getIt.registerSingleton<ProjectProvider>(
    ProjectProvider(getIt<ProjectRepository>()),
  );

  getIt.registerSingleton<TodoProvider>(
    TodoProvider(getIt<TodoRepository>()),
  );
}
