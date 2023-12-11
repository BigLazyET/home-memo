import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_memo/base/page_base.dart';
import 'package:home_memo/utils/log/log_util.dart';
import 'package:home_memo/viewmodels/main_view_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulPageWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends PageState<MainPage> {
  DateTime? lastPopTime;
  late MainViewModel mainViewModel;

  @override
  void initState() {
    super.initState();

    mainViewModel = MainViewModel();
    mainViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffEFF1F4),
        body: WillPopScope(
            onWillPop: () async {
              // 点击返回键的操作
              // if (lastPopTime == null || DateTime.now().difference(lastPopTime!) > const Duration(seconds: 1)) {
              if (lastPopTime == null || DateTime.now().difference(lastPopTime!).inSeconds > 1) {
                lastPopTime = DateTime.now();
                LogUtil.n('再按一次 Back 按钮退出');
                // https://docs.flutter.dev/release/breaking-changes/scaffold-messenger
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('再按一次 Back 按钮退出')));
                return false;
              } else {
                LogUtil.n('App退出应用');
                // https://api.flutter.dev/flutter/services/SystemNavigator/pop.html
                await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                return true;
              }
            },
            child: ChangeNotifierProvider(
                create: (context) {},
                child: Selector(
                    builder: (a, b, c) {
                      return Column(
                        children: [Expanded(child: const Text('xxx'))],
                      );
                    },
                    selector: (_, a) {}))));
  }
}
