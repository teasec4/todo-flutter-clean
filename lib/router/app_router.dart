import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:isar_test_todo/pages/projects/projects_page.dart'
    as projects_page;
import 'package:isar_test_todo/pages/todos/todos_page.dart' as todos_page;

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const projects_page.ProjectsPage(),
          routes: [
            GoRoute(
              path: ':projectId/todos',
              builder: (context, state) {
                final idParam = state.pathParameters['projectId'];
                final projectId = int.tryParse(idParam ?? '');
                if (projectId == null) {
                  return const Scaffold(
                    body: Center(child: Text('Invalid project id')),
                  );
                }
                return todos_page.TodosPage(projectId: projectId);
              },
            ),
          ],
        ),
      ],
    );
  }
}
