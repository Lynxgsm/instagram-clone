import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/viewing.dart';
import 'package:instagram/src/views/screens/home/user/user.viewmodel.dart';
import 'package:instagram/src/views/widgets/avatar.dart';
import 'package:instagram/src/views/widgets/buttons.dart';
import 'package:instagram/src/views/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserViewModel>.reactive(
        onModelReady: (model) => model.init(),
        builder: (context, model, _) => Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: model.isLoading
                  ? Loader()
                  : Column(
                      children: [
                        ListTile(
                          leading: Avatar(model.user.avatar),
                          title: Text(model.user.username),
                        ),
                        Viewing.spacing(height: 8),
                        Spacer(),
                        PrimaryButton(
                          "Se déconnecter",
                          icon: Icons.logout,
                          action: () => model.logout(context),
                        )
                      ],
                    ),
            ),
        viewModelBuilder: () => UserViewModel());
  }
}
