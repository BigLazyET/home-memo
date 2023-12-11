import 'package:flutter/material.dart';
import 'package:home_memo/utils/log/log_util.dart';

class FlutterRouterManager {
  Map<String, PageRoute> routeStack = {};

  addRoute(PageRoute route) {
    final routeName = getRouteName(route);
    if (routeName is String) {
      routeStack.addAll({routeName: route});
      LogUtil.i("路由栈: ${routeStack.values.toString()}");
    } else {
      LogUtil.w("不合法的路由");
    }
  }

  removeRoute(PageRoute route) {
    if (routeStack.values.contains(route)) {
      final routeName = getRouteName(route);
      routeStack.remove(routeName);
    } else {
      LogUtil.w("路由栈中不存在此路由");
    }
  }

  String? getRouteName(Route<dynamic> route) {
    if (route is PageRoute) {
      return route.settings.name;
    }
    return null;
  }
}
