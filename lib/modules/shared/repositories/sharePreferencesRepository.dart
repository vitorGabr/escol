import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesRepository {

  static SharePreferencesRepository _instance;
  
  factory SharePreferencesRepository() {
    _instance ??= SharePreferencesRepository._internalConstructor();
    
    return _instance;
  }

  SharePreferencesRepository._internalConstructor();

  Future<void> removeSharedPrerencesAsync(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(key);
  }

  Future<void> removeAllSharedPrerencesAsync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  Future<String> containsKeyAsync(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String keyResult = prefs.getString(key) ?? "";

    return keyResult;
  }

  Future<bool> containsKeyBoolAsync(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool keyResult = prefs.getBool(key) ?? false;

    return keyResult;
  }

  Future<void> saveSharedPrerencesAsync(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, value);
  }

  Future<void> saveSharedPrerencesBoolAsync(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(key, value);
  }
}