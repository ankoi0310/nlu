import 'package:shared_preferences/shared_preferences.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100);
}

String createPostUri(
    {String baseUrl = 'https://dkmh.hcmuaf.edu.vn/#/home/listbaiviet',
    String kyKieu = 'tb',
    int page = 1,
    required String id}) {
  return '$baseUrl/$kyKieu/page/$page/baivietct/$id';
}

Future<void> saveStringToPrefs(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<void> saveIntToPrefs(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<void> saveBoolToPrefs(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<String?> getStringFromPrefs(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<int?> getIntFromPrefs(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}

Future<bool?> getBoolFromPrefs(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

Future<void> removeFromPrefs(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future<void> clearPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
