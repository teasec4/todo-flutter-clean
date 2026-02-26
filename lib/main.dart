import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/core/theme/app_theme.dart';
import 'package:isar_test_todo/data/repository/project_repository_impl.dart';
import 'package:isar_test_todo/provider/app_initializer.dart';
import 'package:isar_test_todo/provider/project_provider.dart';
import 'package:isar_test_todo/provider/todo_provider.dart';
import 'package:isar_test_todo/router/app_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Isar.initializeIsarCore(download: true);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppInitializer()..init()),
        ChangeNotifierProvider(
          create: (context) {
            
            return TodoProvider();
          },
        ),
        ChangeNotifierProvider(create: (context) => ProjectProvider(
          ProjectRepositoryImpl(isar: context.read<AppInitializer>().isar)
        ),)
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final init = context.watch<AppInitializer>();
    return MaterialApp.router(
      title: '待办事项应用',
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.createRouter(init),
    );
  }
}
