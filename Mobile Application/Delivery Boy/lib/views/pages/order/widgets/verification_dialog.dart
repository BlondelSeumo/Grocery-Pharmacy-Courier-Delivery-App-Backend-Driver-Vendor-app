import 'package:flutter/material.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/buttons/custom_text_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderVerificationDialog extends StatefulWidget {
  OrderVerificationDialog(
      {this.order, this.onValidated, this.openQRCodeScanner, Key key})
      : super(key: key);

  //
  final Order order;
  final Function onValidated;
  final Function openQRCodeScanner;
  @override
  _OrderVerificationDialogState createState() =>
      _OrderVerificationDialogState();
}

class _OrderVerificationDialogState extends State<OrderVerificationDialog> {
  //
  TextEditingController verificationCodeTEC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: VStack(
        [
          //
          "Verification Code".i18n.text.semiBold.xl.make(),
          "Please enter verification code provided by the customer."
              .i18n
              .text
              .make(),
          //
          CustomTextFormField(
            hintText: "Verification Code".i18n,
            textEditingController: verificationCodeTEC,
            validator: (value) => FormValidator.validateVerificationCode(
              value,
              code: widget.order.verificationCode,
              errorTitle: "Verification Code".i18n,
            ),
          ).py12(),
          VStack(
            [
              //
              CustomButton(
                title: "Verify".i18n,
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    //
                    widget.onValidated();
                  }
                },
              ),
              //
              CustomTextButton(
                title: "Scan Verification Code".i18n,
                onPressed: () {
                  widget.openQRCodeScanner();
                },
              ).centered().py8(),
            ],
          ),
        ],
      ).p20().pOnly(bottom: context.mq.viewPadding.bottom),
    );
  }
}
