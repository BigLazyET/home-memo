import 'package:flutter/material.dart';
import 'package:home_memo/constants.dart';
import 'package:home_memo/routes/router_facade.dart';
import 'package:home_memo/routes/routes_union.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () {
        // precheck: privacy，other permissions check
        // 跳转主页面
        _pushMainPage();
        // 一般在这里可以进行隐私权益的处理
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: AppInfo.screenWidth,
        height: AppInfo.screenHeight,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://images.dog.ceo/breeds/retriever-golden/n02099601_5452.jpg'))),
        child: const Center(child: Text('Home Memo')),
      ),
    );
  }

  _pushMainPage() {
    _initData();

    RouteFacade.instance.pushReplacement(context, RoutesUnion.MAIN_PAGE);
  }

  _initData() {
    RouteFacade.instance.registRoutes();
    RouteFacade.instance.registRouteInterceptors();
  }
}
