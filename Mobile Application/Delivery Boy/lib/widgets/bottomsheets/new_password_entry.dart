import 'package:flutter/material.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/view_models/forgot_password.view_model.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/forgot_password.i18n.dart';

class NewPasswordEntry extends StatefulWidget {
  const NewPasswordEntry({this.onSubmit, this.vm, Key key}) : super(key: key);

  final Function(String) onSubmit;
  final ForgotPasswordViewModel vm;

  @override
  _NewPasswordEntryState createState() => _NewPasswordEntryState();
}

class _NewPasswordEntryState extends State<NewPasswordEntry> {
  final resetFormKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    //

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
            textEditingController: widget.vm.passwordTEC,
            validator: FormValidator.validatePassword,
            obscureText: true,
          ).py12(),

          //submit
          CustomButton(
            title: "Reset Password".i18n,
            onPressed: () {
              if (resetFormKey.currentState.validate()) {
                widget.onSubmit(widget.vm.passwordTEC.text);
              }
            },
          ).h(Vx.dp48),
        ],
      ).p20().h(context.percentHeight * 90),
    );
  }
}
