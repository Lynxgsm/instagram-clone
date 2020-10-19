import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/src/helpers/auth.handler.dart';
import 'package:instagram/src/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static Future<UserModel> getUser() async {
    SharedPreferences stockage = await SharedPreferences.getInstance();
    // FirebaseAuth.instance.currentUser().then((value) => null);
    return stockage.get("instagram_user") != null
        ? UserModel.fromJSON(json.decode(stockage.get("instagram_user")))
        : null;
  }

  static Future<UserModel> getUserInfo(String uid) async {
    UserModel _user;
    await Firestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .getDocuments()
        .then((user) {
      _user = UserModel.fromJSON(user.documents[0].data);
    });

    return _user;
  }

  static Future<void> setUser(UserModel user) async {
    SharedPreferences stockage = await SharedPreferences.getInstance();
    stockage.setString("instagram_user", json.encode(user.toJSON()));
  }

  static Future<AuthResultStatus> login(String email, String password) async {
    AuthResultStatus _status;
    try {
      AuthResult authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  static Future<FirebaseUser> getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  static Future<AuthResultStatus> registerInfo(
      String email, String password) async {
    AuthResultStatus _status;
    try {
      AuthResult authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }

    return _status;
  }

  static Future<void> addUserInfo(UserModel user) {
    return Firestore.instance.collection("users").add(user.toJSON());
  }

  static Future<void> logout() async {
    SharedPreferences stockage = await SharedPreferences.getInstance();
    FirebaseAuth.instance.signOut().then((value) async {
      await stockage.remove("instagram_user");
    });
  }
}
