import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_memo/constants.dart';
import 'package:home_memo/defines/colors.dart';

class MainSkeletonWidget extends StatefulWidget {
  const MainSkeletonWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainSkeletonWidgetState();
  }
}

class MainSkeletonWidgetState extends State<MainSkeletonWidget> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  Color? _color;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Stack(
        children: [
          Image(
              image: const AssetImage('assets/images/img_gradient_bg.png'),
              height: 220.r,
              width: double.infinity,
              fit: BoxFit.fill),
          Column(
            children: [SizedBox(height: AppInfo.safeTopHeight + 60.r)],
          )
        ],
      ),
    );
  }

  void _initAnimation() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _animation = Tween<double>(begin: 0.04, end: 0.1).animate(_animationController!);
    _animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController?.forward();
      }
    });
  }

  void _doAfterFirstFrame() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _animationController?.forward();
        _color = AppColors.black;
      });
    });
  }

  void _disposeAnimation() {
    _animationController?.dispose();
    _animationController = null;
    _animation = null;
  }

  Widget _placeholderWidget({double? width, double? height, Color? color, BorderRadiusGeometry? borderRadius}) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(color: color ?? _color, borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(4.r))),
    );
  }
}
