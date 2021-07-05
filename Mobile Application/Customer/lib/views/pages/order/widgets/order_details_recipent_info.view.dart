import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderDetailsRecipentInfoView extends StatelessWidget {
  const OrderDetailsRecipentInfoView(this.vm, {Key key}) : super(key: key);
  final OrderDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        vm.order.recipientName != null && vm.order.recipientName.isNotBlank
            ? HStack(
                [
                  //
                  VStack(
                    [
                      "Recipient Name".i18n.text.gray500.medium.sm.make(),
                      vm.order.recipientName
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
                    color: AppColor.primaryColor,
                    shapeRadius: Vx.dp24,
                    onPressed: vm.callRecipient,
                  ).wh(Vx.dp64, Vx.dp40).p12(),
                ],
              )
            : UiSpacer.emptySpace(),
      ],
    );
  }
}
