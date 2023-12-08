class MainBottomTabItem {
  /// tab名称
  late String tabName;
  //String? tabPosition;
  /// 点击事件 0.直接呈现，1.跳转
  late num clickEvent;

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

  MainBottomTabItem.fromJson(dynamic json) {
    clickEvent = json["clickEvent"];
    selectedImageUrl = json["selectedImageUrl"];
    unSelectImageUrl = json["unSelectImageUrl"];
    width = json["width"];
    height = json["height"];
    redirectUrl = json["redirectUrl"];
    cornerMark = json["cornerMark"];
    id = json["id"];
    tabName = json["tabName"];
  }

  Map<String, dynamic> toJson() {
    // Map<String, dynamic> map = {};
    final map = <String, dynamic>{};
    map["clickEvent"] = clickEvent;
    map["selectedImageUrl"] = selectedImageUrl;
    map["unSelectImageUrl"] = unSelectImageUrl;
    map["width"] = width;
    map["height"] = height;
    map["redirectUrl"] = redirectUrl;
    map["cornerMark"] = cornerMark;
    map["id"] = id;
    map["tabName"] = tabName;
    return map;
  }

  @override
  String toString() {
    return "MainBottomTabItem clickEvent:$clickEvent, selectedImageUrl:$selectedImageUrl, unSelectImageUrl:$unSelectImageUrl, width:$width, height:$height, redirectUrl:$redirectUrl, cornerMark:$cornerMark, id:$id, tabName:$tabName";
  }
}
