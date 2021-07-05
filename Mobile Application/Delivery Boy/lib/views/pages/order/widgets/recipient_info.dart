import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/translations/order_details.i18n.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class RecipientInfo extends StatelessWidget {
  const RecipientInfo({
    this.callRecipient,
    this.order,
    Key key,
  }) : super(key: key);

  final Function callRecipient;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return order.recipientName != null && order.recipientName.isNotBlank
        ? HStack(
            [
              //
              VStack(
                [
                  "Recipient Name".i18n.text.gray500.medium.sm.make(),
                  order.recipientName
                      .allWordsCapitilize()
                      .text
                      .medium
                      .xl
                      .make()
                      .pOnly(bottom: Vx.dp20),
                ],
              ).expand(),
              //call
              CustomButton(
                icon: FlutterIcons.phone_call_fea,
                iconColor: Colors.white,
                title: "",
                color: Colors.green,
                shapeRadius: Vx.dp24,
                onPressed: callRecipient,
              ).wh(Vx.dp64, Vx.dp40).p12(),
            ],
          )
        : UiSpacer.emptySpace();
  }
}
