import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/auth.handler.dart';
import 'package:instagram/src/helpers/routing.dart';
import 'package:instagram/src/services/user.service.dart';
import 'package:instagram/src/views/screens/home/home.view.dart';
import 'package:instagram/src/views/screens/register/register.view.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

class LoginViewModel extends BaseViewModel {
  Map<String, String> _user = {};
  bool _isLoading = false;

  Map<String, String> get user => _user;
  bool get isLoading => _isLoading;

  void handleInput(String name, String value) {
    _user[name] = value;
  }

  void login(BuildContext context) {
    _isLoading = true;
    notifyListeners();
    UserService.login(_user["email"], _user["password"]).then((status) {
      if (status == AuthResultStatus.successful) {
        UserService.getCurrentUser().then((value) {
          UserService.getUserInfo(value.uid).then((user) {
            UserService.setUser(user).then((value) {
              Routing.goto(context, HomeView(), isReplaced: true);
            });
          });
        });
      } else {
        Toast.show(
            AuthExceptionHandler.generateExceptionMessage(status), context,
            duration: 4);
        _isLoading = false;
        notifyListeners();
      }
    }).catchError((onError) => throw (onError));
  }

  void gotoRegister(BuildContext context) {
    Routing.goto(context, RegisterView());
  }
}
