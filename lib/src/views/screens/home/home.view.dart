import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/routing.dart';
import 'package:instagram/src/views/screens/home/camera/camera.view.dart';
import 'package:instagram/src/views/screens/home/feed/feed.view.dart';
import 'package:instagram/src/views/screens/home/home.viewmodel.dart';
import 'package:instagram/src/views/screens/home/user/user.view.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, _) => SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    title: Image.asset(
                      "images/logo.png",
                      width: 125,
                    ),
                    actions: [
                      Container(
                        width: 40,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(model.user.avatar))),
                      )
                    ],
                    leading: IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Routing.goto(context, CameraView());
                        }),
                  ),
                  body: Container(
                      child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: model.controller,
                    children: [FeedView(), UserView()],
                  )),
                  bottomNavigationBar: Container(
                    child: Card(
                      child: Row(
                        children: model.items
                            .asMap()
                            .map((index, child) => MapEntry(
                                  index,
                                  Expanded(
                                    child: IconButton(
                                        icon: Icon(child.icon),
                                        onPressed: () {
                                          model.changeScreen(index);
                                        }),
                                  ),
                                ))
                            .values
                            .toList(),
                      ),
                    ),
                  )),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
