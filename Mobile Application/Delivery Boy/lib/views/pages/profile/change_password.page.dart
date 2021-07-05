import 'package:flutter/material.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/view_models/change_password.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/profile.i18n.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      viewModelBuilder: () => ChangePasswordViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          title: "Change Password".i18n,
          body: SafeArea(
              top: true,
              bottom: false,
              child:
                  //
                  VStack(
                [

                  //form
                  Form(
                    key: model.formKey,
                    child: VStack(
                      [
                        //
                        CustomTextFormField(
                          labelText: "Current Password".i18n,
                          obscureText: true,
                          textEditingController: model.currentPasswordTEC,
                          validator: FormValidator.validatePassword,
                        ).py12(),
                        //
                        CustomTextFormField(
                          labelText: "New Password".i18n,
                          obscureText: true,
                          textEditingController: model.newPasswordTEC,
                          validator: FormValidator.validatePassword,
                        ).py12(),
                        //
                        CustomTextFormField(
                          labelText: "Confirm New Password".i18n,
                          obscureText: true,
                          textEditingController: model.confirmNewPasswordTEC,
                          validator: FormValidator.validatePassword,
                        ).py12(),

                        //
                        CustomButton(
                          title: "Update Password".i18n,
                          loading: model.isBusy,
                          onPressed: model.processUpdate,
                        ).centered().py12(),
                      ],
                    ),
                  ),
                ],
              ).p20().scrollVertical()),
        );
      },
    );
  }
}
