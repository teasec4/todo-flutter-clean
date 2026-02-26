import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/core/di/service_locator.dart';
import 'package:isar_test_todo/core/theme/app_theme.dart';
import 'package:isar_test_todo/provider/app_initializer.dart';
import 'package:isar_test_todo/provider/project_provider.dart';
import 'package:isar_test_todo/provider/todo_provider.dart';
import 'package:isar_test_todo/router/app_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Isar.initializeIsarCore(download: true);

  final appInit = AppInitializer();
  await appInit.init();

  setupServiceLocator(appInit.isar);

  runApp(MyApp(appInit: appInit));
}

class MyApp extends StatelessWidget {
  final AppInitializer appInit;

  const MyApp({super.key, required this.appInit});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<ProjectProvider>()),
        ChangeNotifierProvider.value(value: getIt<TodoProvider>()),
      ],
      child: MaterialApp.router(
        title: '待办事项应用',
        theme: AppTheme.lightTheme(),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.createRouter(appInit),
      ),
    );
  }
}
