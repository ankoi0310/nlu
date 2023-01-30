import 'package:shared_preferences/shared_preferences.dart';

class AppUtil {
  static Future<void> saveToPrefs(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> getFromPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> removeFromPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
