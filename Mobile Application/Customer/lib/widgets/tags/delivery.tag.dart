import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/translations/vendor/top_vendor.i18n.dart';
import 'package:velocity_x/velocity_x.dart';

class DeliveryTag extends StatelessWidget {
  const DeliveryTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return "Delivery"
                    .i18n
                    .text
                    .white
                    .make()
                    .py4()
                    .px8()
                    .box
                    .roundedLg
                    .color(AppColor.deliveryColor)
                    .make();
  }
}
