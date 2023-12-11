import 'package:home_memo/models/device_info.dart';

class AppLocalKeys {
  static const String appTitle = 'app-title';
}

class AppInfo {
  /// 屏幕宽度
  static double screenWidth = 0;

  /// 屏幕高度
  static double screenHeight = 0;

  /// 顶部安全区域
  static double safeTopHeight = 0;

  /// 底部安全区域
  static double safeBottomHeight = 0;

  /// 设备像素比
  static double devicePixelRatio = 1;

  /// 设备信息
  static DeviceInfo? deviceInfo;

  /// 当前 version
  static String? version;

  /// 当前 build number
  static String? buildNumber;

  /// 当前 package name/ bundle id
  static String? packageName;

  static String toText() {
    return "AppInfo screenWidth:$screenWidth, screenHeight:$screenHeight, safeTopHeight:$safeTopHeight, safeBottomHeight:$safeBottomHeight, devicePixelRatio:$devicePixelRatio, version:${AppInfo.version}, buildNumber:${AppInfo.buildNumber}, packageName:${AppInfo.packageName}, deviceInfo:${deviceInfo.toString()}";
  }
}

class SharedPreferenceKeys {
  static const String THEME_MODE = 'theme-mode';
}
