import 'package:flutter/material.dart';

class Viewing {
  static SizedBox spacing({double width, double height}) {
    return SizedBox(
      width: width ?? 0,
      height: height ?? 0,
    );
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
