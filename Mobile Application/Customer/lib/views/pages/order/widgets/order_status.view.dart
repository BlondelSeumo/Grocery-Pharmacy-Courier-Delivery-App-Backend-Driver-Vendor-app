import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:jiffy/jiffy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderStatusView extends StatelessWidget {
  const OrderStatusView(this.vm, {Key key}) : super(key: key);

  final OrderDetailsViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        "Status".i18n.text.gray500.medium.sm.make(),
        vm.order.status
            .allWordsCapitilize()
            .text
            .color(AppColor.getStausColor(vm.order.status))
            .medium
            .xl
            .make()
            .pOnly(bottom: Vx.dp20),

        //scheduled order info
        vm.order.isScheduled
            ? HStack(
                [
                  //date
                  VStack(
                    [
                      //
                      "Scheduled Date".i18n.text.gray500.medium.sm.make(),
                      "${vm.order.pickupDate}"
                          .text
                          .color(AppColor.getStausColor(vm.order.status))
                          .medium
                          .xl
                          .make()
                          .pOnly(bottom: Vx.dp20),
                    ],
                  ).expand(),
                  //time
                  VStack(
                    [
                      //
                      "Scheduled Time".i18n.text.gray500.medium.sm.make(),
                      "${Jiffy(vm.order.pickupTime).format("hh:mm a")}"
                          .text
                          .color(AppColor.getStausColor(vm.order.status))
                          .medium
                          .xl
                          .make()
                          .pOnly(bottom: Vx.dp20),
                    ],
                  ).expand(),
                ],
              )
            : UiSpacer.emptySpace(),
      ],
    );
  }
}
