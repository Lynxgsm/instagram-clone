import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/viewing.dart';
import 'package:instagram/src/views/screens/home/camera/camera.viewmodel.dart';
import 'package:instagram/src/views/widgets/buttons.dart';
import 'package:stacked/stacked.dart';

class CameraView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CameraViewModel>.reactive(
        onModelReady: (model) {},
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                title: Text(
                  "Post a photo",
                  style: TextStyle(color: Colors.black),
                ),
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
              ),
              body: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Add some stories to your newsfeed. Share the fun!"),
                    Spacer(),
                    GridingImage(),
                    Spacer(),
                    PrimaryButton(
                      "Use camera",
                      action: () => model.takePhoto(context),
                    ),
                    Viewing.spacing(height: 16),
                    PrimaryButton("Pick from gallery",
                        icon: Icons.picture_in_picture,
                        action: () => model.pickPhoto(context))
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => CameraViewModel());
  }
}

class GridingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Viewing.height(context) * .5,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          cellItem("images/1.jpg"),
          cellItem("images/2.jpg"),
          cellItem("images/3.jpg"),
          cellItem("images/4.jpg")
        ],
      ),
    );
  }
}

Container cellItem(String image) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
  );
}
