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
  AnimationController? animationController;
  Animation<double>? animation;

  Color? color;

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
    animationController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    animation = Tween<double>(begin: 0.04, end: 0.1).animate(animationController!);
    animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController?.forward();
      }
    });
  }

  void _doAfterFirstFrame() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        animationController?.forward();
        color = AppColors.black;
      });
    });
  }

  void _disposeAnimation() {
    animationController?.dispose();
    animationController = null;
    animation = null;
  }

  Widget _placeholderWidget() {}
}
