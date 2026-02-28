import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/core/theme/app_theme.dart';
import 'package:isar_test_todo/provider/app_initializer.dart';
import 'package:isar_test_todo/router/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Isar.initializeIsarCore(download: true);

  final appInit = AppInitializer();
  await appInit.init();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '待办事项应用',
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.createRouter(),
    );
  }
}
