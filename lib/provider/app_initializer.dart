import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/domain/entity/project_entity.dart';
import 'package:isar_test_todo/domain/entity/todo_entity.dart';
import 'package:path_provider/path_provider.dart';

enum AppInitState { loading, ready, error }

class AppInitializer with ChangeNotifier {
  AppInitState _state = AppInitState.loading;
  AppInitState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late Isar _isar;
  Isar get isar => _isar;

  bool _initialized = false;
  bool get initialized => _initialized;

  Future<void> init() async {
    if (_initialized) {
      developer.log('AppInitializer already initialized, skipping init()');
      return;
    }

    try {
      _state = AppInitState.loading;
      _errorMessage = null;
      notifyListeners();

      developer.log('Initializing app...');

      final dir = await getApplicationDocumentsDirectory();
      developer.log('App documents directory: ${dir.path}');

      _isar = await Isar.open(
        [ProjectEntitySchema, TodoEntitySchema],
        directory: dir.path,
      );

      _initialized = true;
      _state = AppInitState.ready;
      developer.log('App initialized successfully');
      notifyListeners();
    } catch (e) {
      _state = AppInitState.error;
      _errorMessage = e.toString();
      developer.log('App initialization error: $e', error: e);
      notifyListeners();
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    if (_initialized) {
      await _isar.close();
      developer.log('Isar database closed');
    }
    super.dispose();
  }
}
