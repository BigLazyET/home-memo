class DeviceInfo {
  /// 品牌：如 华为
  String? brand;

  /// 型号：出厂型号，真正的型号需要做适配
  String? model;

  /// 机型，如mate 20 Pro
  String? marketName;

  /// 设备ID：iOS端优先级 IDFA>IDFV，安卓端OAID>IMEI>AndoridID
  String? deviceId;

  /// 设备ID类型：如:IDFV,IDFA,OAID,IMEI等
  String? deviceIdType;

  /// 系统版本：如android6.0；iOS 16.0.0
  String? osVersion;

  /// SDK版本：如android 23(6.0),33(12)；iOS 等同于 version
  String? sdk;

  /// 系统名
  String? os;

  /// 渠道名称
  String? channelName;

  DeviceInfo(
      {this.brand, this.model, this.deviceId, this.osVersion, this.sdk, this.os, this.deviceIdType, this.marketName});

  @override
  String toString() {
    return 'DeviceInfo{brand: $brand, model: $model, deviceId: $deviceId, osVersion: $osVersion,sdk: $sdk,  os: $os, deviceIdType: $deviceIdType, channelName: $channelName,marketName:$marketName}';
  }

  Map<String, dynamic> toJson() {
    return {
      "brand": brand,
      "model": model,
      "deviceId": deviceId,
      "version": osVersion,
      "sdk": sdk,
      "os": os,
      "deviceIdType": deviceIdType,
      "marketName": marketName,
    };
  }

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    return DeviceInfo(
      brand: json["brand"],
      model: json["model"],
      deviceId: json["deviceId"],
      osVersion: json["osVersion"],
      sdk: json["sdk"],
      os: json["os"],
      deviceIdType: json["deviceIdType"],
      marketName: json["marketName"],
    );
  }
}
