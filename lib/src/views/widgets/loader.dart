import 'package:flutter/material.dart';
import 'package:instagram/src/constants/colors.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(ThemeColor.loaderColor),
          )
        ],
      ),
    );
  }
}
