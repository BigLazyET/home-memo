import 'package:flutter/material.dart';
import 'package:home_memo/models/main/main_bottom_tab_item.dart';

class MainViewModel extends ChangeNotifier {
  /// 是否展示骨架屏
  bool skeleton = true;

  /// 首页底部tab item列表
  List<MainBottomTabItem> mainBottomTabItems = [];

  /// 当前选中的tab item
  MainBottomTabItem? currentMainBottomTabItem;
}
