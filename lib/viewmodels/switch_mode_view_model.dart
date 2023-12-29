import 'package:flutter/material.dart';
import 'package:home_memo/constants.dart';
import 'package:home_memo/utils/data/shared_perference_util.dart';

class SwitchModeViewModel with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    // // 获取当前平台的亮度
    // var platformBrightness = MediaQuery.of(appNavigatorKey.currentContext!).platformBrightness;
    // // 根据平台亮度来决定使用亮色主题还是暗色主题
    // bool isDarkMode = platformBrightness == Brightness.dark;

    var mode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setTheme(mode);
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    SpUtil.setValue<ThemeMode>(SharedPreferenceKeys.THEME_MODE, themeMode);
  }
}
