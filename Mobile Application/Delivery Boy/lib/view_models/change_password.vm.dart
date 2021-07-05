import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fuodz/models/user.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/profile.i18n.dart';

class ChangePasswordViewModel extends MyBaseViewModel {
  User currentUser;
  File newPhoto;
  //the textediting controllers
  TextEditingController currentPasswordTEC = new TextEditingController();
  TextEditingController newPasswordTEC = new TextEditingController();
  TextEditingController confirmNewPasswordTEC = new TextEditingController();

  //
  AuthRequest _authRequest = AuthRequest();
  final picker = ImagePicker();

  ChangePasswordViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  processUpdate() async {
    //
    if (formKey.currentState.validate()) {
      //
      setBusy(true);

      //
      final apiResponse = await _authRequest.updatePassword(
        password: currentPasswordTEC.text,
        new_password: newPasswordTEC.text,
        new_password_confirmation: confirmNewPasswordTEC.text,
      );

      //
      setBusy(false);

      //
      CoolAlert.show(
        context: viewContext,
        type: apiResponse.allGood ? CoolAlertType.success : CoolAlertType.error,
        title: "Change Password".i18n,
        text: apiResponse.message,
        onConfirmBtnTap: apiResponse.allGood
            ? () {
                //
                viewContext.pop();
                viewContext.pop(true);
              }
            : null,
      );
    }
  }
}
