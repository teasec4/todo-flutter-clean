import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_test_todo/domain/entity/todo_entity.dart';
import 'package:path_provider/path_provider.dart';

enum AppInitState { loading, ready, error }

class AppInitializer with ChangeNotifier {
  AppInitState _state = AppInitState.loading;
  AppInitState get state => _state;

  late Isar _isar;
  Isar get isar => _isar;

  Future<void> init() async {
    try {
      _state = AppInitState.loading;
      notifyListeners();

      final dir = await getApplicationDocumentsDirectory();

      _isar = await Isar.open([TodoEntitySchema], directory: dir.path);

      _state = AppInitState.ready;
      notifyListeners();
    } catch (e) {
      _state = AppInitState.error;
      notifyListeners();
    }
  }
}
