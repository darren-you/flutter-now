import 'package:flutternow/constants/prefrences_keys.dart';
import 'package:flutternow/managers/local_storage_manager.dart';

class FirstLaunchManager {
  FirstLaunchManager._();

  static FirstLaunchManager? _instance;

  static FirstLaunchManager get instance {
    _instance ??= FirstLaunchManager._();
    return _instance!;
  }

  /// 设定App首次启动
  void setAppFirstLaunch() {
    final firstLaunchTime =
        LocalStorageManager.instance.getString(PreferencesKeys.firstLaunchTime);
    if (firstLaunchTime == null || firstLaunchTime.isEmpty) {
      LocalStorageManager.instance
          .setString(PreferencesKeys.firstLaunchTime, '${DateTime.now()}');
    }
  }

  /// 是否为首次启动
  bool isFirstTimeLaunch() {
    final firstLaunchTime =
        LocalStorageManager.instance.getString(PreferencesKeys.firstLaunchTime);
    if (firstLaunchTime == null || firstLaunchTime.isEmpty) {
      return true;
    }
    return false;
  }

  /// 首次启动时间
  String? getFirstLaunchTime() {
    return LocalStorageManager.instance
        .getString(PreferencesKeys.firstLaunchTime);
  }

  /// 清空首次启动
  void restFirstLaunchTime() {
    LocalStorageManager.instance
        .setString(PreferencesKeys.firstLaunchTime, null);
  }
}
