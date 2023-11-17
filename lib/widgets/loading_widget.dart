import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_memo/defines/colors.dart';
import 'package:home_memo/utils/color_util.dart';

class LoadingWidget extends StatefulWidget {
  double? width;
  double? height;
  String? textTip;

  LoadingWidget({super.key, this.width, this.height, this.textTip});

  @override
  State<StatefulWidget> createState() => LoadingWidgetState();
}

class LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    // 每一帧渲染前（一个vsync信号）
    animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();
    animation = Tween<double>(begin: 0, end: 1).animate(animationController!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            width: widget.width ?? 120.w,
            height: widget.height ?? 120.w,
            decoration: ShapeDecoration(
                color: const Color(0xB3000000),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r)))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RotationTransition(
                    turns: animation!,
                    child: Image.asset(
                      'assets/images/img_loading.png',
                      width: 40.r,
                      height: 40.r,
                    )),
                widget.textTip == null || widget.textTip!.isEmpty
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: 20.r, left: 10.r, right: 10.r),
                        child: Text(
                          widget.textTip!,
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
