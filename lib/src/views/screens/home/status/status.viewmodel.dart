import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/src/helpers/routing.dart';
import 'package:instagram/src/models/feed.model.dart';
import 'package:instagram/src/services/feed.service.dart';
import 'package:instagram/src/services/image.service.dart';
import 'package:instagram/src/services/user.service.dart';
import 'package:instagram/src/views/screens/home/home.view.dart';
import 'package:stacked/stacked.dart';

class StatusViewModel extends BaseViewModel {
  Uint8List _file;
  PickedFile _pickedFile;
  Uint8List get file => _file;
  Map<String, String> _feed = {};
  bool _isLoading = false;

  Map<String, String> get feed => _feed;
  bool get isLoading => _isLoading;

  void handleInput(String name, String value) {
    _feed[name] = value;
  }

  void init(PickedFile file) {
    _pickedFile = file;
    file.readAsBytes().then((value) {
      _file = value;
      notifyListeners();
    });
  }

  void submit(BuildContext context) {
    _isLoading = true;
    notifyListeners();

    UserService.getUser().then((value) {
      ImageService.sendFile(_pickedFile).then((path) {
        FeedModel feed = FeedModel(
            author: value,
            description: _feed["description"],
            images: [path],
            place: _feed["place"],
            tags: _feed["tags"].split(","),
            views: 0,
            date: Timestamp.now());

        FeedService.sendFeed(feed).then((feedResult) {
          _isLoading = false;
          notifyListeners();
          Routing.goto(context, HomeView());
        });
      });
    });
  }
}
