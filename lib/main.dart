import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_memo/base/page_base.dart';
import 'package:home_memo/constants.dart';
import 'package:home_memo/defines/colors.dart';
import 'package:home_memo/pages/splash_page.dart';
import 'package:home_memo/pages/test/my_home_page.dart';
import 'package:home_memo/utils/localize_util.dart';
import 'package:home_memo/utils/log/log_util.dart';
import 'package:home_memo/viewmodels/switch_mode_view_model.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import 'global.dart';

const bool isOpenDoKit = false; //todo 日志开关

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 全局framework异常捕获
  FlutterError.onError = (FlutterErrorDetails details) {
    LogUtil.e('FlutterErrorDetails异常捕获: “${details.toString()}"');
  };

  // 设置状态栏模式，Android有效，iOS需要设置info.plist
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.transparent));
  // 设置屏幕方向
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // 初始化数据
  await _initData();

  // 运行
  await _runApp();
}

_initData() async {
  // 本地化
  LogUtil.i('本地化设置');
  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  await ScreenUtil.ensureScreenSize();
  // TODO: jsbridge
}

_runApp() async {
  if (isOpenDoKit) {
    // await DoKit.runApp(
    //   appCreator: () async {
    //     return DoKitApp(const MyApp());
    //   },
    //   // 是否在release包内使用，默认release包会禁用
    //   useInRelease: true,
    //   // 选择性控制是否使用dokit中的runZonedGuarded,false: 禁用；true: 启用
    //   useRunZoned: true,
    //   // 调用print方法打印日志时被回调
    //   logCallback: (_) {},
    //   // 过滤方法通道的黑名单
    //   methodChannelBlackList: [],
    //   // release模式下执行该函数，该值为空则会直接调用系统的runApp
    //   releaseAction: () async {},
    //   // 异常回调
    //   // exceptionCallback: (dynamic object, StackTrace stack) {
    //   //   LogUtil.e("代码异常捕获 object: $object \nstack: $stack");
    //   // },
    // );
  } else {
    runZonedGuarded(() => runApp(const MyApp()), (error, stack) {
      LogUtil.e("代码异常捕获 error: $error \nstack: $stack");
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SwitchModeViewModel(),
            lazy: false,
          )
        ],
        child: Consumer<SwitchModeViewModel>(
            builder: (context, switchModeViewModel, child) => ScreenUtilInit(
                designSize: const Size(375, 812), //设计稿中设备的尺寸(单位随意,建议dp,但在使用过程中必须保持一致)
                minTextAdapt: true, //是否根据宽度/高度中的最小值适配文字
                splitScreenMode: true, //支持分屏尺寸
                builder: (_, child) => MaterialApp(
                      // 本地化
                      localizationsDelegates: [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                        LocalJsonLocalization.delegate
                      ],
                      supportedLocales: const [
                        Locale('en', 'US'),
                        Locale('zh', 'CN')
                        //Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN', scriptCode: 'Hans') // zh_Hans_CN.json
                      ],
                      localeResolutionCallback: (locale, supportedLocales) {
                        if (supportedLocales.contains(locale)) {
                          return locale;
                        } else {
                          for (var supportedLocale in supportedLocales) {
                            if (supportedLocale.languageCode == locale!.languageCode) {
                              return supportedLocale;
                            }
                          }
                        }
                        return null;
                      },
                      navigatorObservers: [routeObserver],
                      title: LocalUtil.get(AppLocalKeys.appTitle),
                      navigatorKey: appNavigatorKey,
                      theme: switchModeViewModel.themeMode == 1
                          ? ThemeData.dark()
                          : ThemeData(
                              primarySwatch: Colors.blue, // 用于导航栏、FloatingActionButton的背景色等
                            ),
                      home: const SplashPage(),
                      builder: (context, child) {
                        return Overlay(initialEntries: [
                          if (child != null) ...[
                            // ...用来拼接集合
                            OverlayEntry(builder: (context) {
                              AppInfo.screenWidth = ScreenUtil().screenWidth;
                              AppInfo.screenHeight = ScreenUtil().screenHeight;
                              AppInfo.safeTopHeight = MediaQuery.of(context).padding.top;
                              AppInfo.safeBottomHeight = MediaQuery.of(context).padding.bottom;
                              AppInfo.devicePixelRatio = MediaQuery.of(context).devicePixelRatio <= 0
                                  ? 1
                                  : MediaQuery.of(context).devicePixelRatio;

                              return MediaQuery(
                                  // 设置文字大小不随系统设置改变
                                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // 全局点击空白区域关闭键盘
                                      var currentFocus = FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                      }
                                    },
                                    child: child,
                                  ));
                            })
                          ]
                        ]);
                      },
                      //home: MyHomePage(title: '${LocalUtil.get(AppLocalKeys.appTitle)} Home Page'),
                    ))));
  }
}
