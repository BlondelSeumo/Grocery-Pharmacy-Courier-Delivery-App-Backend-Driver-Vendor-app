import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/dialogs.i18n.dart';

class LoginViewModel extends MyBaseViewModel {
  //the textediting controllers
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  //
  AuthRequest _authRequest = AuthRequest();

  LoginViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void initialise() {
    //
    emailTEC.text = kReleaseMode ? "" : "client@demo.com";
    passwordTEC.text = kReleaseMode ? "" : "password";
  }

  void processLogin() async {
    // Validate returns true if the form is valid, otherwise false.
    if (formKey.currentState.validate()) {
      //

      setBusy(true);

      final apiResponse = await _authRequest.loginRequest(
        email: emailTEC.text,
        password: passwordTEC.text,
      );

      setBusy(false);

      try {
        if (apiResponse.hasError()) {
          //there was an error
          CoolAlert.show(
            context: viewContext,
            type: CoolAlertType.error,
            title: "Login Failed".i18n,
            text: apiResponse.message,
          );
        } else {
          //everything works well
          //firebase auth
          final fbToken = apiResponse.body["fb_token"];
          await FirebaseAuth.instance.signInWithCustomToken(fbToken);
          await AuthServices.saveUser(apiResponse.body["user"]);
          await AuthServices.setAuthBearerToken(apiResponse.body["token"]);
          await AuthServices.isAuthenticated();
          viewContext.pop(true);
        }
      } on FirebaseAuthException catch (error) {
        CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Login Failed".i18n,
          text: "${error.message}",
        );
      } catch (error) {
        CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Login Failed".i18n,
          text: "${error['message'] ?? error}",
        );
      }
    }
  }

  void openRegister() async {
    viewContext.navigator.pushNamed(
      AppRoutes.registerRoute,
    );
  }

  void openForgotPassword() {
    viewContext.navigator.pushNamed(
      AppRoutes.forgotPasswordRoute,
    );
  }
}
