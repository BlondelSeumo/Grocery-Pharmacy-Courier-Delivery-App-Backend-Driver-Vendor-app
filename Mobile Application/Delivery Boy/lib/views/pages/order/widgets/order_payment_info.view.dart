import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderPaymentInfoView extends StatelessWidget {
  const OrderPaymentInfoView(this.vm, {Key key}) : super(key: key);
  final OrderDetailsViewModel vm;

  //
  @override
  Widget build(BuildContext context) {
    return HStack(
      [

        //Payment option
        VStack(
          [
            //
            "Payment Method".i18n.text.gray500.medium.sm.make(),
            //
            vm.order.paymentMethod.name
                .allWordsCapitilize()
                .text
                .medium
                .xl
                .make(),
            //
          ],
        ).pOnly(bottom: Vx.dp20).expand(),


        //Payment status
        VStack(
          [
            //
            "Payment Status".i18n.text.gray500.medium.sm.make(),
            //
            vm.order.paymentStatus
                .allWordsCapitilize()
                .text
                .color(AppColor.getStausColor(vm.order.paymentStatus))
                .medium
                .xl
                .make(),
            //
          ],
        ).pOnly(bottom: Vx.dp20).expand(),
      ],
    );
  }
}
