import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/routing.dart';
import 'package:instagram/src/services/user.service.dart';
import 'package:instagram/src/views/screens/home/home.view.dart';
import 'package:instagram/src/views/screens/login/login.view.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  void init(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      UserService.getUser().then((value) {
        value != null
            ? Routing.goto(context, HomeView(), isReplaced: true)
            : Routing.goto(context, LoginView(), isReplaced: true);
      });
    });
  }
}
