import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderDetailsDriverInfoView extends StatelessWidget {
  const OrderDetailsDriverInfoView(this.vm, {Key key}) : super(key: key);
  final OrderDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        vm.order.driver != null
            ? HStack(
                [
                  //
                  VStack(
                    [
                      "Driver".i18n.text.gray500.medium.sm.make(),
                      vm.order.driver.name
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
                    shapeRadius: Vx.dp48,
                    onPressed: vm.callDriver,
                  ).wh(Vx.dp64, Vx.dp40).p12(),
                ],
              )
            : UiSpacer.emptySpace(),
        vm.order.canChatDriver
            ? CustomButton(
                icon: FlutterIcons.chat_ent,
                iconColor: Colors.white,
                title: "Chat with driver".i18n,
                color: AppColor.primaryColor,
                onPressed: vm.chatDriver,
              ).h(Vx.dp48).pOnly(top: Vx.dp12, bottom: Vx.dp20)
            : UiSpacer.emptySpace(),

        //rate driver
        vm.order.canRateDriver
            ? CustomButton(
                icon: FlutterIcons.rate_review_mdi,
                iconColor: Colors.white,
                title: "Rate The Driver".i18n,
                color: AppColor.primaryColor,
                onPressed: vm.rateDriver,
              ).h(Vx.dp48).pOnly(top: Vx.dp12, bottom: Vx.dp20)
            : UiSpacer.emptySpace(),
      ],
    );
  }
}
