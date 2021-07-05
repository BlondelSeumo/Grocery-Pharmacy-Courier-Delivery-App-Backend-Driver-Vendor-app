import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/view_models/vendor_details.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor.i18n.dart';

class VendorSalesChart extends StatelessWidget {
  const VendorSalesChart({this.vm, Key key}) : super(key: key);

  final VendorDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        "Orders Report".i18n.text.white.xl2.semiBold.make(),
        "Weekly sales report".i18n.text.white.xl.medium.make(),
        //
        HStack(
          [
            "${vm.WeekFirstDay}".text.white.lg.medium.make(),
            "  -  ".text.white.make(),
            "${vm.WeekLastDay}".text.white.lg.medium.make(),
          ],
        ),
        //
        BarChart(
          vm.mainBarData(),
        ).h(context.percentHeight * 20).pOnly(top: Vx.dp20),
      ],
    )
        .py20()
        .px16()
        .box
        .rounded
        .color(AppColor.accentColor.withOpacity(0.8))
        .shadow
        .make();
  }
}
