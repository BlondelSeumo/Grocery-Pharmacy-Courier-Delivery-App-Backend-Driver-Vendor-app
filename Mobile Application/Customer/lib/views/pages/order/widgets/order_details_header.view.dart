import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderDetailsHeaderView extends StatelessWidget {
  const OrderDetailsHeaderView(this.vm, {Key key}) : super(key: key);
  final OrderDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //code & total amount
        HStack(
          [
            //
            VStack(
              [
                "Code".i18n.text.gray500.medium.sm.make(),
                "#${vm.order.code}".text.medium.xl.make(),
              ],
            ).expand(),
            //total amount
            AppStrings.currencySymbol.text.medium.lg.make().px4(),
            (vm.order.total ?? 0.00).numCurrency.text.medium.xl2.make(),
          ],
        ).pOnly(bottom: Vx.dp20),
        HStack(
          [
            VStack(
              [
                "Verification Code".i18n.text.gray500.medium.sm.make(),
                "${vm.order.verificationCode}".text.medium.xl.make(),
              ],
            ).expand(),
            //qr code icon
            Icon(
              FlutterIcons.qrcode_ant,
              size: 28,
            ).onInkTap(vm.showVerificationQRCode),
          ],
        ).wFull(context).pOnly(bottom: Vx.dp20),
      ],
    );
  }
}
