import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class Transitions {
  static sharedAxisPageTransition(Widget screen, bool isHorizontal) {
    SharedAxisTransitionType _transitionType = isHorizontal
        ? SharedAxisTransitionType.horizontal
        : SharedAxisTransitionType.vertical;

    return PageRouteBuilder<SharedAxisTransition>(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SharedAxisTransition(
            child: child,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: _transitionType,
          );
        });
  }
}
