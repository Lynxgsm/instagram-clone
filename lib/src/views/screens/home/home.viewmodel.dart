import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram/src/models/user.model.dart';
import 'package:instagram/src/services/user.service.dart';
import 'package:stacked/stacked.dart';

class BottomItem {
  IconData icon;
  BottomItem(this.icon);
}

class HomeViewModel extends BaseViewModel {
  List<DocumentSnapshot> _feeds;
  List<BottomItem> _items = [
    BottomItem(Icons.home_outlined),
    // BottomItem(Icons.search_outlined),
    // BottomItem(Icons.add_box_outlined),
    // BottomItem(Icons.favorite_border_outlined),
    BottomItem(Icons.person_outlined)
  ];

  UserModel _user;
  PageController _controller = new PageController();

  List<DocumentSnapshot> get feeds => _feeds;
  UserModel get user => _user;
  PageController get controller => _controller;
  List<BottomItem> get items => _items;

  void init() {
    UserService.getUser().then((value) {
      _user = value;
      notifyListeners();
    });
  }

  void changeScreen(int index) {
    _controller.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
