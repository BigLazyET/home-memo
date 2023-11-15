import 'package:flutter/material.dart';

///路由观察者
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
    // TODO: implement didPop
    super.didPop();
  }

  @override
  void didPush() {
    // TODO: implement didPush
    super.didPush();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
