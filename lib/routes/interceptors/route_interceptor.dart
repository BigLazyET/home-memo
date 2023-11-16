import 'package:flutter/src/widgets/framework.dart';
import 'package:home_memo/routes/interceptors/route_interceptor_base.dart';
import 'package:home_memo/routes/routes_union.dart';
import 'package:home_memo/utils/user_session.dart';

class RouteInterceptor extends RouteInterceptorBase {
  @override
  Future<bool> willPush(BuildContext context, String routeName,
      {String? customName, Map<String, dynamic>? params}) async {
    switch (routeName) {
      case RoutesUnion.ACCOUNT_MANAGER_PAGE:
        return UserSeesion().isLogin;
    }

    return true;
  }

  @override
  Future<bool> willPushReplacement(BuildContext context, String routeName,
      {String? customName, Map<String, dynamic>? params}) async {
    return Future.value(true);
  }
}
