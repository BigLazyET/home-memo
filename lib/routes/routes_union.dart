import 'package:flutter/material.dart';
import 'package:home_memo/pages/main/main_page.dart';
import 'package:home_memo/pages/splash_page.dart';

class RoutesUnion {
  // 启动页
  static const String SPLASH_PAGE = "SplashPage";

  // 欢迎页
  static const String WELCOME_PAGE = "WelcomePage";

  // 主页
  static const String MAIN_PAGE = "MainPage";

  //账户管理页
  static const String ACCOUNT_MANAGER_PAGE = "AccountManagerPage";

  // 路由集合
  static Map<String, FlutterPageBuilder> map = {
    SPLASH_PAGE: (params) => const SplashPage(),
    MAIN_PAGE: (params) => MainPage()
  };
}

typedef Widget FlutterPageBuilder(Map params);
// typedef FlutterPageBuilder = Widget Function(Map params);