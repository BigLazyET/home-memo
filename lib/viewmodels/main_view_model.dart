import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:flutter/material.dart';
import 'package:home_memo/constants.dart';
import 'package:home_memo/models/device_info.dart';
import 'package:home_memo/models/main/main_bottom_tab_item.dart';
import 'package:home_memo/utils/data/json_util.dart';
import 'package:home_memo/utils/log/log_util.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainViewModel extends ChangeNotifier {
  /// 是否展示骨架屏
  bool skeleton = true;

  /// 首页底部tab item列表
  List<MainBottomTabItem> mainBottomTabItems = [];

  /// 当前选中的tab item
  MainBottomTabItem? currentMainBottomTabItem;

  init() async {
    await _initDeviceInfo();
    await _initPackageInfo();
    await _initMainBottomTabItems();
  }

  setCurrentMainBottomTabItem(MainBottomTabItem tabItem) {
    currentMainBottomTabItem = tabItem;
    LogUtil.i("设置当前的 Bottom Tab Item: ${tabItem.tabName}");
  }

  _initDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    DeviceMarketingNames deviceMarketingNames = DeviceMarketingNames();

    DeviceInfo deviceInfo = DeviceInfo();

    // TODO: 原生plugin 获取device id
    // TODO: 原生plugin 获取渠道
    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      deviceInfo.brand = androidDeviceInfo.brand;
      deviceInfo.model = androidDeviceInfo.model;
      deviceInfo.osVersion = androidDeviceInfo.version.release; // Platform.operatingSystemVersion
      deviceInfo.sdk = androidDeviceInfo.version.sdkInt.toString();
      deviceInfo.os = Platform.operatingSystem;
      deviceInfo.marketName = deviceMarketingNames.getSingleNameFromModel(DeviceType.android, deviceInfo.model!);
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfoPlugin.iosInfo;
      deviceInfo.brand = 'Apple';
      deviceInfo.model = iosInfo.utsname.machine; // iosInfo.model;
      deviceInfo.marketName = deviceMarketingNames.getSingleNameFromModel(DeviceType.ios, deviceInfo.model!);
      deviceInfo.osVersion = iosInfo.systemVersion;
      deviceInfo.sdk = iosInfo.systemVersion;
      deviceInfo.os = Platform.operatingSystem;
      deviceInfo.channelName = "IOS";
    }
    LogUtil.i("设备信息：${deviceInfo.toString()}");
    AppInfo.deviceInfo = deviceInfo;
  }

  _initPackageInfo() async {
    var packageInfo = await PackageInfo.fromPlatform();
    AppInfo.version = packageInfo.version;
    AppInfo.buildNumber = packageInfo.buildNumber;
    AppInfo.packageName = packageInfo.packageName;

    LogUtil.i(
        "包信息: version:${AppInfo.version}, buildNumber:${AppInfo.buildNumber}, packageName:${AppInfo.packageName}");
  }

  _initMainBottomTabItems() async {
    mainBottomTabItems =
        await JsonUtil.loadAndDeserializeJson<List<MainBottomTabItem>>("assets/data/main.json", (json) {
      List<MainBottomTabItem> tabItems = [];
      if (json["tabItems"] != null) {
        json["tabItems"].forEach((v) {
          tabItems.add(MainBottomTabItem.fromJson(v));
        });
      }
      return tabItems;
    });

    if (currentMainBottomTabItem == null && mainBottomTabItems.isNotEmpty) {
      currentMainBottomTabItem = mainBottomTabItems[0];
    }

    // 此方法跟ChangeNotifier相关，用于通知
    notifyListeners();
  }
}
