import 'package:flutter/material.dart';
import 'package:home_memo/constants.dart';
import 'package:home_memo/utils/data/shared_perference_util.dart';

class SwitchModeViewModel with ChangeNotifier {
  int _themeMode = 1; // 0: 日渐, 1: 夜间, 2: 跟随系统

  int get themeMode => _themeMode;

  void switchMode(int mode) {
    _themeMode = mode;

    notifyListeners();
    SpUtil.setValue<int>(SharedPreferenceKeys.THEME_MODE, themeMode);
  }
}
