import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fuodz/models/user.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/dialogs.i18n.dart';

class EditProfileViewModel extends MyBaseViewModel {
  User currentUser;
  File newPhoto;
  //the textediting controllers
  TextEditingController nameTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController phoneTEC = new TextEditingController();

  //
  AuthRequest _authRequest = AuthRequest();
  final picker = ImagePicker();

  EditProfileViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void initialise() async {
    //
    currentUser = await AuthServices.getCurrentUser();
    nameTEC.text = currentUser.name;
    emailTEC.text = currentUser.email;
    phoneTEC.text = currentUser.phone;
    notifyListeners();
  }

  //
  void changePhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      newPhoto = File(pickedFile.path);
    } else {
      newPhoto = null;
    }

    notifyListeners();
  }

  //
  processUpdate() async {
    //
    if (formKey.currentState.validate()) {
      //
      setBusy(true);

      //
      final apiResponse = await _authRequest.updateProfile(
        photo: newPhoto,
        name: nameTEC.text,
        email: emailTEC.text,
        phone: phoneTEC.text,
      );

      //
      setBusy(false);

      //update local data if all good
      if (apiResponse.allGood) {
        //everything works well
        await AuthServices.saveUser(apiResponse.body["user"]);
      }

      //
      CoolAlert.show(
        context: viewContext,
        type: apiResponse.allGood ? CoolAlertType.success : CoolAlertType.error,
        title: "Profile Update".i18n,
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
