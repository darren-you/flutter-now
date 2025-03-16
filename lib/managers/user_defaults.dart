import 'package:shared_preferences/shared_preferences.dart';

/// 用户偏好数据本地缓存管理类
class UserDefaults {
  static final instance = UserDefaults();
  late SharedPreferences prefs;

  /// SharedPreferences初始化
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  int? getInt(String key) {
    return prefs.getInt(key);
  }

  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  void setString(String key, String? value) {
    if (value != null) {
      prefs.setString(key, value);
    } else {
      prefs.remove(key);
    }
  }

  void setInt(String key, int? value) {
    if (value != null) {
      prefs.setInt(key, value);
    } else {
      prefs.remove(key);
    }
  }

  void setBool(String key, bool? value) {
    if (value != null) {
      prefs.setBool(key, value);
    } else {
      prefs.remove(key);
    }
  }
}
