import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/constants/shared_prefs_keys.dart' show SharedPrefsKeys;
import '../models/todo.dart';

class SharedPrefsService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<Todo> getTodos() {
    final storedStrings = _prefs.getStringList(SharedPrefsKeys.todos) ?? [];
    return storedStrings.map(Todo.fromString).toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final encoded = todos.map((e) => e.toString()).toList();
    await _prefs.setStringList(SharedPrefsKeys.todos, encoded);
  }

  bool getThemeMode() => _prefs.getBool(SharedPrefsKeys.isDarkMode) ?? false;

  Future<void> setThemeMode(bool isDarkMode) async {
    await _prefs.setBool(SharedPrefsKeys.isDarkMode, isDarkMode);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
