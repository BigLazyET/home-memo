import 'package:flutter/material.dart';
import 'package:home_memo/global.dart';
import 'package:home_memo/routes/flutter_router.dart';
import 'package:home_memo/routes/interceptors/route_interceptor.dart';
import 'package:home_memo/routes/routes_union.dart';
import 'package:home_memo/routes/transitions/route_transition_type.dart';
import 'package:home_memo/utils/log/log.dart';
import 'package:home_memo/utils/log/log_util.dart';

class RouteController {
  static void RegistRoutes() {
    FlutterRouter.addPages(RoutesUnion.map);
  }

  static void RegistRouteInterceptors() {
    FlutterRouter.addInterceptor(RouteInterceptor());
  }

  /// hack:https://stackoverflow.com/questions/46483949/how-to-get-current-route-path-in-flutter
  static String? currentRoute() {
    String? currentPath;
    appNavigatorKey.currentState?.popUntil((route) {
      currentPath = route.settings.name;
      return true;
    });
    return currentPath;
  }

  static Future<dynamic> push(BuildContext context, String routeName, {Map<String, dynamic>? params}) {
    return FlutterRouter.push(context, routeName, params: params, transitionType: RouteTransitionType.inFromRight);
  }

  static Future<dynamic> pushReplacement(BuildContext context, String routeName, {Map<String, dynamic>? params}) {
    LogUtil.i('pushReplacement from ${currentRoute()} to $routeName');
    return FlutterRouter.pushReplacement(context, routeName, params: params);
  }

  static Future<dynamic> pushAndRemoveUntil(BuildContext context, String routeName, {RoutePredicate? predicate}) {
    return FlutterRouter.pushAndRemoveUntil(context, routeName, predicate ?? (route) => false);
  }

  static void pop(BuildContext context, {Map<String, dynamic>? result}) {
    FlutterRouter().pop(context, result: result);
  }

  static void popUntil(BuildContext context, String routeName) {
    FlutterRouter().popUntil(context, routeName);
  }
}
