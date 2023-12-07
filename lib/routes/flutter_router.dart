import 'package:flutter/material.dart';
import 'package:home_memo/routes/interceptors/route_interceptor_base.dart';
import 'package:home_memo/routes/routes_union.dart';
import 'package:home_memo/routes/transitions/route_transition_builder.dart';
import 'package:home_memo/routes/transitions/route_transition_type.dart';

class FlutterRouter {
  FlutterRouter._internal();
  factory FlutterRouter() => _instance;
  static late final FlutterRouter _instance = FlutterRouter._internal();

  static const defaultTransitionDuration = Duration(milliseconds: 250);

  static RouteInterceptorBase? interceptor;
  static Map<String, FlutterPageBuilder> allPages = <String, FlutterPageBuilder>{};

  static addInterceptor(RouteInterceptorBase interceptor) => interceptor = interceptor;

  static void addPages(Map<String, FlutterPageBuilder> pages) => allPages.addAll(pages);

  static bool isValidRoute(String routeName) => allPages.containsKey(routeName);

  static Route<dynamic> _buildRoute(String routeName,
      {String? customName,
      Map<String, dynamic>? params,
      RouteTransitionType? transitionType,
      RouteTransitionBuilder? transitionBuilder,
      Duration transitionDuration = defaultTransitionDuration,
      bool? opaque}) {
    var routeSettings = RouteSettings(name: customName ?? routeName);
    var page = allPages[routeName]!(params ?? {});

    if (transitionType == null) {
      return MaterialPageRoute(settings: routeSettings, builder: (BuildContext context) => page);
    }

    transitionBuilder = transitionBuilder ?? buildTransitionBuilder(transitionType);
    transitionDuration = transitionType == RouteTransitionType.none ? Duration.zero : transitionDuration;

    var pageRouteBuilder = PageRouteBuilder<dynamic>(
        settings: routeSettings,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        opaque: opaque ?? true,
        transitionDuration: transitionDuration,
        reverseTransitionDuration: transitionDuration,
        transitionsBuilder: transitionType == RouteTransitionType.none
            ? (context, animation, secondaryAnimation, child) => child
            : transitionBuilder);

    return pageRouteBuilder;
  }

  static Future<dynamic> push(BuildContext context, String routeName,
      {String? customName,
      Map<String, dynamic>? params,
      RouteTransitionType? transitionType,
      RouteTransitionBuilder? transitionBuilder,
      Duration transitionDuration = defaultTransitionDuration,
      bool? opaque}) async {
    if (!isValidRoute(routeName)) {
      return Future.value();
    }
    if (interceptor != null) {
      var isValid = await interceptor!.willPush(context, routeName, customName: customName, params: params);
      if (!isValid) {
        return Future.value();
      }
    }

    var route = _buildRoute(routeName,
        params: params,
        transitionType: transitionType,
        transitionBuilder: transitionBuilder,
        transitionDuration: transitionDuration,
        opaque: opaque);
    return Navigator.of(context).push(route);
  }

  static Future<dynamic> pushReplacement(BuildContext context, String routeName,
      {String? customName,
      Map<String, dynamic>? params,
      RouteTransitionType? transitionType,
      RouteTransitionBuilder? transitionBuilder,
      Duration transitionDuration = defaultTransitionDuration,
      bool? opaque}) async {
    if (!isValidRoute(routeName)) {
      return Future.value();
    }
    if (interceptor != null) {
      var isValid = await interceptor!.willPush(context, routeName, customName: customName, params: params);
      if (!isValid) {
        return Future.value();
      }
    }

    var route = _buildRoute(routeName,
        params: params,
        transitionType: transitionType,
        transitionBuilder: transitionBuilder,
        transitionDuration: transitionDuration,
        opaque: opaque);
    return Navigator.of(context).pushReplacement(route);
  }

  static Future<dynamic> pushAndRemoveUntil(BuildContext context, String routeName, RoutePredicate predicate,
      {String? customName,
      Map<String, dynamic>? params,
      RouteTransitionType? transitionType,
      RouteTransitionBuilder? transitionBuilder,
      Duration transitionDuration = defaultTransitionDuration,
      bool? opaque}) async {
    if (!isValidRoute(routeName)) {
      return Future.value();
    }
    if (interceptor != null) {
      var isValid = await interceptor!.willPush(context, routeName, customName: customName, params: params);
      if (!isValid) {
        return Future.value();
      }
    }

    var route = _buildRoute(routeName,
        params: params,
        transitionType: transitionType,
        transitionBuilder: transitionBuilder,
        transitionDuration: transitionDuration,
        opaque: opaque);
    return Navigator.of(context).pushAndRemoveUntil(route, predicate);
  }

  void pop(BuildContext context, {Map<String, dynamic>? result}) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(result);
    }
  }

  void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil((route) => route.settings.name == routeName);
  }

  void removePage(BuildContext context, String routeName) {}
}
