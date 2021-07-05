import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/views/pages/cart/widgets/amount_tile.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/general.i18n.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    this.subTotal,
    this.discount,
    this.deliveryFee,
    this.tax,
    this.vendorTax,
    this.total,
    this.driverTip = 0.00,
    Key key,
  }) : super(key: key);

  final double subTotal;
  final double discount;
  final double deliveryFee;
  final double tax;
  final String vendorTax;
  final double total;
  final double driverTip;
  @override
  Widget build(BuildContext context) {
    final currencySymbol = AppStrings.currencySymbol;
    return VStack(
      [
        "Order Summary".i18n.text.semiBold.xl.make().pOnly(bottom: Vx.dp12),
        AmountTile("Subtotal".i18n, subTotal.numCurrency).py2(),
        AmountTile("Discount".i18n, "- $currencySymbol ${discount.numCurrency}")
            .py2(),
        AmountTile("Delivery Fee".i18n,
                "+ $currencySymbol ${deliveryFee.numCurrency}")
            .py2(),
        AmountTile("Tax (%s)".i18n.fill([vendorTax]),
                "+ $currencySymbol ${tax.numCurrency}")
            .py2(),
        DottedLine(dashColor: context.textTheme.bodyText1.color).py8(),
        Visibility(
          visible: driverTip != null && driverTip > 0,
          child: VStack(
            [
              AmountTile("Driver Tip".i18n,
                      "+ $currencySymbol ${driverTip.numCurrency}")
                  .py2(),
              DottedLine(dashColor: context.textTheme.bodyText1.color).py8(),
            ],
          ),
        ),
        AmountTile("Total Amount".i18n, "$currencySymbol ${total.numCurrency}"),
      ],
    );
  }
}
