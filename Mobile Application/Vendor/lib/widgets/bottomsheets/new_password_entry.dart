import 'package:flutter/material.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/view_models/forgot_password.view_model.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/forgot_password.i18n.dart';

class NewPasswordEntry extends StatelessWidget {
  const NewPasswordEntry({this.onSubmit, this.vm, Key key}) : super(key: key);

  final Function(String) onSubmit;
  final ForgotPasswordViewModel vm;

  @override
  Widget build(BuildContext context) {
    //
    final resetFormKey = GlobalKey<FormState>();

    return Form(
      key: resetFormKey,
      child: VStack(
        [
          //
          "New Password".i18n.text.bold.xl2.makeCentered(),
          "Please enter account new password".i18n.text.makeCentered(),
          //pin code
          CustomTextFormField(
            labelText: "New Password".i18n,
            textEditingController: vm.passwordTEC,
            validator: FormValidator.validatePassword,
            obscureText: true,
          ).py12(),

          //submit
          CustomButton(
            title: "Reset Password".i18n,
            loading: vm.isBusy,
            onPressed: () {
              if (resetFormKey.currentState.validate()) {
                onSubmit(vm.passwordTEC.text);
              }
            },
          ).h(Vx.dp48),
        ],
      ).p20().h(context.percentHeight * 90),
    );
  }
}
