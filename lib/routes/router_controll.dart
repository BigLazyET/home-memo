import 'package:flutter/material.dart';
import 'package:home_memo/routes/flutter_router.dart';
import 'package:home_memo/routes/interceptors/route_interceptor.dart';
import 'package:home_memo/routes/routes_union.dart';
import 'package:home_memo/routes/transitions/route_transition_type.dart';

class RouteController {
  static void RegistRoutes() {
    FlutterRouter().addPages(RoutesUnion.map);
  }

  static void RegistRouteInterceptors() {
    FlutterRouter().addInterceptor(RouteInterceptor());
  }

  static Future<dynamic> push(BuildContext context, String routeName, {Map<String, dynamic>? params}) {
    return FlutterRouter().push(context, routeName, params: params, transitionType: RouteTransitionType.inFromRight);
  }

  static Future<dynamic> pushReplacement(BuildContext context, String routeName, {Map<String, dynamic>? params}) {
    return FlutterRouter().pushReplacement(context, routeName, params: params);
  }

  static Future<dynamic> pushAndRemoveUntil(BuildContext context, String routeName, {RoutePredicate? predicate}) {
    return FlutterRouter().pushAndRemoveUntil(context, routeName, predicate ?? (route) => false);
  }

  static void pop(BuildContext context, {Map<String, dynamic>? result}) {
    FlutterRouter().pop(context, result: result);
  }

  static void popUntil(BuildContext context, String routeName) {
    FlutterRouter().popUntil(context, routeName);
  }
}
