import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_memo/utils/log/log_util.dart';

class ToastUtil {
  static late final ToastUtil _instance = ToastUtil._internal();
  ToastUtil._internal();
  factory ToastUtil() => _instance;

  static void showToast(
      {Image? icon, ToastGravity? gravity, Duration? toastDuration, Duration? fadeDuration, required String msg}) {
    LogUtil.n(msg);
  }
}
