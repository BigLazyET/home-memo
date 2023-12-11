import 'package:flutter/material.dart';
import 'package:home_memo/routes/flutter_router.dart';
import 'package:home_memo/routes/interceptors/route_interceptor.dart';
import 'package:home_memo/routes/routes_union.dart';
import 'package:home_memo/routes/transitions/route_transition_type.dart';
import 'package:home_memo/utils/log/log_util.dart';

class RouteFacade {
  RouteFacade._internal();
  static late final RouteFacade _instance = RouteFacade._internal();
  // factory RouteFacade() => _instance;
  static RouteFacade get instance => _instance;

  FlutterRouter flutterRouter = FlutterRouter();

  // late final String currentRouteName = flutterRouter.currentRouteName();
  String get currentRouteName => flutterRouter.currentRouteName();

  void registRoutes() {
    flutterRouter.addPages(RoutesUnion.map);
  }

  void registRouteInterceptors() {
    flutterRouter.addInterceptor(RouteInterceptor());
  }

  /// hack:https://stackoverflow.com/questions/46483949/how-to-get-current-route-path-in-flutter
  // static String? currentRoute() {
  //   String? currentPath;
  //   appNavigatorKey.currentState?.popUntil((route) {
  //     currentPath = route.settings.name;
  //     return true;
  //   });
  //   return currentPath;
  // }

  Future<dynamic> push(BuildContext context, String routeName, {Map<String, dynamic>? params}) {
    return flutterRouter.push(context, routeName, params: params, transitionType: RouteTransitionType.inFromRight);
  }

  Future<dynamic> pushReplacement(BuildContext context, String routeName, {Map<String, dynamic>? params}) {
    LogUtil.i('pushReplacement from $currentRouteName to $routeName');
    return flutterRouter.pushReplacement(context, routeName, params: params);
  }

  Future<dynamic> pushAndRemoveUntil(BuildContext context, String routeName, {RoutePredicate? predicate}) {
    return flutterRouter.pushAndRemoveUntil(context, routeName, predicate ?? (route) => false);
  }

  void pop(BuildContext context, {Map<String, dynamic>? result}) {
    flutterRouter.pop(context, result: result);
  }

  void popUntil(BuildContext context, String routeName) {
    FlutterRouter().popUntil(context, routeName);
  }
}
