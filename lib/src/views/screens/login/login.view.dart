import 'package:flutter/material.dart';
import 'package:instagram/src/helpers/viewing.dart';
import 'package:instagram/src/views/screens/login/login.viewmodel.dart';
import 'package:instagram/src/views/widgets/buttons.dart';
import 'package:instagram/src/views/widgets/input.dart';
import 'package:instagram/src/views/widgets/loader.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        builder: (context, model, _) => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 64, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Image.asset(
                        "images/logo.png",
                        width: 200,
                      ),
                      Viewing.spacing(height: 32),
                      Input(
                        "Email",
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
                      Align(
                          alignment: Alignment.centerRight,
                          child: LinkButton("Forgot your password?")),
                      Spacer(),
                      model.isLoading
                          ? Loader()
                          : Column(
                              children: [
                                PrimaryButton("Log In",
                                    icon: Icons.login_rounded,
                                    action: () => model.login(context)),
                                Viewing.spacing(height: 16),
                                SecondaryButton(
                                  "Register",
                                  icon: Icons.save_alt,
                                  action: () => model.gotoRegister(context),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => LoginViewModel());
  }
}
