import 'package:flutter/material.dart';

abstract class RouteInterceptorBase {
  Future<bool> willPush(BuildContext context, String routeName, {String? customName, Map<String, dynamic>? params}) {
    throw UnimplementedError();
  }

  Future<bool> willPushReplacement(BuildContext context, String routeName,
      {String? customName, Map<String, dynamic>? params}) {
    throw UnimplementedError();
  }
}
