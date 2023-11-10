import 'package:flutter/material.dart';

/// https://www.jianshu.com/p/06ddc56b0828
class ColorUtil {
  /// 十六进制颜色
  /// hex: 十六进制值，如 0xffffff
  /// alpha: 透明度 [0.0,1.0]
  static Color fromHex(int hex, {double alpha = 1}) {
    alpha = alpha < 0
        ? 0
        : alpha > 1
            ? 1
            : alpha;
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, (hex & 0x0000FF) >> 0, alpha);
  }

  /// 十六进制颜色
  /// hexString: 十六进制字符串
  static Color fromHexString(String hexString, {double alpha = 1}) {
    if (hexString.isEmpty || hexString.length != 7) {
      return Colors.black;
    }

    var hex = int.tryParse(hexString, radix: 16) ?? 0;
    return fromHex(hex, alpha: alpha);
  }
}
