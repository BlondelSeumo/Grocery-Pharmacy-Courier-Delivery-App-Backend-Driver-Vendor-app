import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/register.i18n.dart';

class AccountVerificationEntry extends StatelessWidget {
  const AccountVerificationEntry({this.onSubmit, this.vm, Key key}) : super(key: key);

  final Function(String) onSubmit;
  final MyBaseViewModel vm;

  
  @override
  Widget build(BuildContext context) {
    //
    TextEditingController pinTEC = new TextEditingController();

    return VStack(
      [
        //
        "Verify your phone number".i18n.text.bold.xl2.makeCentered(),
        "Enter otp sent to your provided phone number".i18n.text.makeCentered(),
        //pin code
        PinCodeTextField(
          appContext: context,
          length: 6,
          obscureText: false,
          keyboardType: TextInputType.number,
          animationType: AnimationType.fade,
          textStyle: context.textTheme.bodyText1.copyWith(fontSize: 20),
          controller: pinTEC,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            fieldHeight: context.percentWidth * (100 / 8),
            fieldWidth: context.percentWidth * (100 / 8),
            activeFillColor: AppColor.primaryColor,
            selectedColor: AppColor.accentColor,
            inactiveColor: context.cardColor,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: false,
          onCompleted: (pin) {
            print("Completed");
            print("Pin ==> $pin");
          },
          onChanged: (value) {
            
          },
        ),

        //submit
        CustomButton(
          title: "Verify".i18n,
          loading: vm.busy(vm.firebaseVerificationId),
          onPressed: () => onSubmit(pinTEC.text),
        ),
      ],
    ).p20().h(context.percentHeight * 90);
  }
}
