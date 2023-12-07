class MainBottomTabItem {
  /// tab名称
  String tabName;
  //String? tabPosition;
  /// 点击事件 0.直接呈现，1.跳转
  num clickEvent;

  /// 选中图片url
  String? selectedImageUrl;

  /// 未选中图片url
  String? unSelectImageUrl;

  /// 图片宽度
  num? width;

  /// 图片高度
  num? height;

  /// 跳转地址
  String? redirectUrl;

  /// 角标文案
  String? cornerMark;

  String? target; //跳转预留
  /// id
  num? id;

  MainBottomTabItem({
    this.clickEvent = 0,
    this.selectedImageUrl,
    this.unSelectImageUrl,
    this.width,
    this.height,
    this.redirectUrl,
    this.cornerMark,
    this.id,
    required this.tabName,
  })  : assert(tabName.isNotEmpty),
        assert(clickEvent == 0 || clickEvent == 1);
}
