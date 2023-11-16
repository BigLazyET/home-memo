import 'package:flutter/material.dart';
import 'package:home_memo/routes/transitions/route_transition_type.dart';

typedef Widget RouteTransitionBuilder(
    BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child);

RouteTransitionBuilder buildTransitionBuilder(RouteTransitionType transitionType) {
  return (
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (transitionType == RouteTransitionType.fadeIn) {
      return FadeTransition(opacity: animation, child: child);
    } else {
      const topLeft = Offset(0.0, 0.0);
      const topRight = Offset(1.0, 0.0);
      const bottomLeft = Offset(0.0, 1.0);

      var startOffset = bottomLeft;
      var endOffset = topLeft;

      if (transitionType == RouteTransitionType.inFromLeft) {
        startOffset = const Offset(-1.0, 0.0);
        endOffset = topLeft;
      } else if (transitionType == RouteTransitionType.inFromRight) {
        startOffset = topRight;
        endOffset = topLeft;
      } else if (transitionType == RouteTransitionType.inFromBottom) {
        startOffset = bottomLeft;
        endOffset = topLeft;
      } else if (transitionType == RouteTransitionType.inFromTop) {
        startOffset = const Offset(0.0, -1.0);
        endOffset = topLeft;
      }

      return SlideTransition(
        position: Tween<Offset>(
          begin: startOffset,
          end: endOffset,
        ).animate(animation),
        child: child,
      );
    }
  };
}
