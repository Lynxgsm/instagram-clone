import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/transitions.dart';

class Routing {
  static void goto(BuildContext context, Widget screen,
      {bool isReplaced: false, bool isHorizontal = true}) {
    isReplaced
        ? Navigator.of(context).pushReplacement(
            Transitions.sharedAxisPageTransition(screen, isHorizontal))
        : Navigator.of(context)
            .push(Transitions.sharedAxisPageTransition(screen, isHorizontal));
  }
}
