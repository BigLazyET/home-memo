import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  // Obtain shared preferences.
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  static Future<T> getValue<T>(String key) async {
    var pref = await prefs;
    var result = pref.get(key);
    if (result is T) {
      return result;
    } else {
      throw Exception("不能得到这种类型");
    }
  }

  static Future<bool> setValue<T>(String key, T value) async {
    var pref = await prefs;
    if (value is int) {
      return pref.setInt(key, value);
    } else if (value is bool) {
      return pref.setBool(key, value);
    } else if (value is double) {
      return pref.setDouble(key, value);
    } else if (value is String) {
      return pref.setString(key, value);
    } else if (value is List<String>) {
      return pref.setStringList(key, value);
    }

    return false;
  }

  static Future<bool> remove(String key) async {
    var pref = await prefs;
    return pref.remove(key);
  }

  static Future<bool> clear() async {
    var pref = await prefs;
    return pref.clear();
  }
}
