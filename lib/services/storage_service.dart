import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

/// Сервис для работы с локальным хранилищем
class StorageService {
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  /// Сохраняет данные пользователя
  Future<void> saveUser(User user) async {
    await _prefs.setString(_userKey, _userToJson(user));
    await _prefs.setBool(_isLoggedInKey, true);
  }

  /// Загружает данные пользователя
  User? getUser() {
    final String? userJson = _prefs.getString(_userKey);
    if (userJson == null) return null;
    return _userFromJson(userJson);
  }

  /// Проверяет, авторизован ли пользователь
  bool isLoggedIn() {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Выход из аккаунта (удаляет данные)
  Future<void> logout() async {
    await _prefs.remove(_userKey);
    await _prefs.setBool(_isLoggedInKey, false);
  }

  /// Преобразует объект User в JSON строку
  String _userToJson(User user) {
    final map = user.toMap();
    return map.entries.map((e) => '${e.key}=${e.value}').join(';');
  }

  /// Преобразует JSON строку в объект User
  User _userFromJson(String json) {
    final map = <String, String>{};
    json.split(';').forEach((pair) {
      final parts = pair.split('=');
      if (parts.length == 2) {
        map[parts[0]] = parts[1];
      }
    });
    return User.fromMap(map);
  }
}
