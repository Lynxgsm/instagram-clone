import 'package:flutter/material.dart';
import 'package:instagram/src/views/screens/splash/splash.view.dart';

void main() async {
  runApp(Instagram());
}

class Instagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Neue"),
      home: SplashView(),
    );
  }
}
