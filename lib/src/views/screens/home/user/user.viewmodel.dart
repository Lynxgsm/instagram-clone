import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/routing.dart';
import 'package:instagram/src/models/user.model.dart';
import 'package:instagram/src/services/user.service.dart';
import 'package:instagram/src/views/screens/login/login.view.dart';
import 'package:stacked/stacked.dart';

class UserViewModel extends BaseViewModel {
  UserModel _user;
  bool _isLoading = false;

  UserModel get user => _user;
  bool get isLoading => _isLoading;

  void init() {
    _isLoading = true;
    notifyListeners();
    UserService.getUser().then((value) {
      _user = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  void logout(BuildContext context) {
    UserService.logout().then((value) {
      Routing.goto(context, LoginView());
    });
  }
}
