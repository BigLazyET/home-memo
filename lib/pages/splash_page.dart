import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:home_memo/constants.dart';

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
  }

  _initData() {}
}
