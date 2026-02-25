import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:isar_test_todo/pages/projects/projects_page.dart'
    as projects_page;
import 'package:isar_test_todo/pages/todos/todos_page.dart' as todos_page;
import 'package:isar_test_todo/provider/app_initializer.dart';

class AppRouter {
  static GoRouter createRouter(AppInitializer init) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: init,
      redirect: (context, state) {
        if (init.state == AppInitState.loading) {
          return 'loading';
        }
        if (init.state == AppInitState.error) {
          return 'error';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const projects_page.ProjectsPage(),
          routes: [
            GoRoute(
              path: '/:projectId/todos',
              builder: (context, state) {
                final projectId = state.pathParameters['projectId'];
                return todos_page.TodosPage(projectId: projectId ?? "unknownId");
              },
            ),
          ],
        ),
        // Isar Init
        GoRoute(
          path: '/loading',
          builder: (context, state) =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
        ),
        // Isar Init ERROR
        GoRoute(
          path: '/error',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('初始化错误'))),
        ),
      ],
    );
  }
}
