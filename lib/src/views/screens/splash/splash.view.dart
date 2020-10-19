import 'package:flutter/material.dart';
import 'package:instagram/src/views/screens/splash/splash.viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        onModelReady: (model) => model.init(context),
        builder: (context, model, _) => Scaffold(
              body: Container(
                width: double.infinity,
                color: Colors.white,
                child: Center(
                    child: Image.asset(
                  "images/mini_logo.jpeg",
                  width: 200,
                )),
              ),
            ),
        viewModelBuilder: () => SplashViewModel());
  }
}
