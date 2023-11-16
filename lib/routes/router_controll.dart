import 'package:home_memo/routes/flutter_router.dart';
import 'package:home_memo/routes/routes_union.dart';

class RouteController {
  void RegistRoutes() {
    FlutterRouter().addPages(RoutesUnion.map);
  }
}
