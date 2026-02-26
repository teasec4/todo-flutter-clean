import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:isar_test_todo/pages/projects/projects_page.dart'
    as projects_page;
import 'package:isar_test_todo/pages/todos/todos_page.dart' as todos_page;
import 'package:isar_test_todo/provider/app_initializer.dart';

class AppRouter {
  static GoRouter createRouter(AppInitializer appInit) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: appInit,
      redirect: (context, state) {
        if (appInit.state == AppInitState.loading) {
          return 'loading';
        }
        if (appInit.state == AppInitState.error) {
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
        // Isar Init
        GoRoute(
          path: '/loading',
          builder: (context, state) =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
        ),
        // Isar Init ERROR
        GoRoute(
          path: '/error',
          builder: (context, state) {
            final errorMsg = appInit.errorMessage ?? '未知错误';
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text('初始化错误', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        errorMsg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
