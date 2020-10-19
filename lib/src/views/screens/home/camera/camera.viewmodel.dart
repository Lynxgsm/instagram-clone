import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/routing.dart';
import 'package:instagram/src/services/image.service.dart';
import 'package:instagram/src/views/screens/home/status/status.view.dart';
import 'package:stacked/stacked.dart';

class CameraViewModel extends BaseViewModel {
  void takePhoto(BuildContext context) {
    ImageService.takePhoto()
        .then((file) => Routing.goto(context, StatusView(file)));
  }

  void pickPhoto(BuildContext context) {
    ImageService.pickPhoto().then((file) {
      if (file != null) {
        Routing.goto(context, StatusView(file));
      }
    });
  }
}
