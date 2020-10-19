import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/viewing.dart';
import 'package:instagram/src/views/screens/register/register.viewmodel.dart';
import 'package:instagram/src/views/widgets/buttons.dart';
import 'package:instagram/src/views/widgets/input.dart';
import 'package:instagram/src/views/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
        builder: (context, model, _) => SafeArea(
              child: Scaffold(
                body: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(top: 64, bottom: 0, left: 24, right: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          "images/logo.png",
                          width: 200,
                        ),
                        Viewing.spacing(height: 32),
                        model.file == null
                            ? InkWell(
                                onTap: () => model.takePicture(),
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 42,
                                      backgroundImage:
                                          AssetImage("images/button_bg.png"),
                                    ),
                                    Positioned(
                                        left: 26,
                                        top: 26,
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 32,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              )
                            : Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(model.file.path))),
                              ),
                        Viewing.spacing(height: 32),
                        Input(
                          "Username",
                          onEdit: (text) {
                            model.handleInput("username", text);
                          },
                        ),
                        Viewing.spacing(height: 8),
                        Input(
                          "Email",
                          type: TextInputType.emailAddress,
                          onEdit: (text) {
                            model.handleInput("email", text);
                          },
                        ),
                        Viewing.spacing(height: 8),
                        PasswordInput(
                          "Password",
                          onEdit: (text) {
                            model.handleInput("password", text);
                          },
                        ),
                        Viewing.spacing(height: 8),
                        PasswordInput(
                          "Confirm your password",
                          onEdit: (text) {
                            model.handleInput("confirm_password", text);
                          },
                        ),
                        Viewing.spacing(height: 32),
                        model.isLoading
                            ? Loader()
                            : Column(
                                children: [
                                  PrimaryButton(
                                    "Register",
                                    icon: Icons.save_alt_outlined,
                                    action: () => model.register(context),
                                  ),
                                  Viewing.spacing(height: 16),
                                  LinkButton(
                                    "Already have an account? Log in here.",
                                    action: () => model.gotoLogin(context),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => RegisterViewModel());
  }
}
