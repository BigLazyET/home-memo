import 'package:flutter/material.dart';

///路由观察者
///RouteObserver 是一个配合RouteAware的一个类，通过这个类可以通知到当前页面应该执行那种生命周期方法，否则只混入RouteAware是不能执行的
///另外还有RouteObserver需要注册在MaterialApp中，这样才能在导航的过程中执行到对应的生命周期方法
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

abstract class StatelessPageWidget extends StatelessWidget {
  const StatelessPageWidget({super.key});
}

abstract class StatefulPageWidget extends StatefulWidget {
  const StatefulPageWidget({super.key});
}

abstract class PageState<T extends StatefulPageWidget> extends State<T>
    with RouteAware, AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  @override
  void didPop() {
    super.didPop();
  }

  @override
  void didPush() {
    super.didPush();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    super.dispose();

    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
  }
}
