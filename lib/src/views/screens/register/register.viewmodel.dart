import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/src/helpers/auth.handler.dart';
import 'package:instagram/src/helpers/routing.dart';
import 'package:instagram/src/models/user.model.dart';
import 'package:instagram/src/services/image.service.dart';
import 'package:instagram/src/services/user.service.dart';
import 'package:instagram/src/views/screens/home/home.view.dart';
import 'package:instagram/src/views/screens/login/login.view.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

class RegisterViewModel extends BaseViewModel {
  Map<String, String> _user = {};
  PickedFile _file;
  bool _isLoading = false;

  Map<String, String> get user => _user;
  PickedFile get file => _file;
  bool get isLoading => _isLoading;

  void handleInput(String name, String value) {
    _user[name] = value;
  }

  void takePicture() {
    ImageService.takePhoto().then((pic) {
      _file = pic;
      notifyListeners();
    });
  }

  void gotoLogin(BuildContext context) {
    Routing.goto(context, LoginView());
  }

  void register(BuildContext context) {
    _isLoading = true;
    notifyListeners();
    UserService.registerInfo(_user["email"], _user["password"]).then((status) {
      if (status == AuthResultStatus.successful) {
        ImageService.sendFile(_file).then((path) {
          UserService.getCurrentUser().then((currentUser) {
            UserModel user = UserModel(
                uid: currentUser.uid,
                avatar: path,
                username: _user["username"]);

            UserService.addUserInfo(user).then((value) {
              UserService.setUser(user).then((value) =>
                  Routing.goto(context, HomeView(), isReplaced: true));
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
    });
  }
}
