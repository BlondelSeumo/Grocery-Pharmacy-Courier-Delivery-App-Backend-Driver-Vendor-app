import 'package:flutter/material.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/product_details.i18n.dart';

class ProductDetailsHeader extends StatelessWidget {
  const ProductDetailsHeader({this.product, Key key}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    //
    final currencySymbol = AppStrings.currencySymbol;

    return VStack(
      [
        //product name, vendor name, and price
        HStack(
          [
            //name
            VStack(
              [
                //product name
                product.name.text.xl.semiBold.make(),
                //vendor name
                product.vendor.name.text.lg.medium.make(),
              ],
            ).expand(),

            //price
            VStack(
              [
                //price
                HStack(
                  [
                    currencySymbol.text.lg.bold.make(),
                    (product.showDiscount
                            ? product.discountPrice.numCurrency
                            : product.price.numCurrency)
                        .text
                        .xl2
                        .bold
                        .make(),
                  ],
                  crossAlignment: CrossAxisAlignment.end,
                ),
                //discount
                product.showDiscount
                    ? HStack(
                        [
                          currencySymbol.text.lineThrough.xs.make(),
                          product.price.numCurrency.text.lineThrough.lg.medium
                              .make(),
                        ],
                      )
                    : UiSpacer.emptySpace(),
              ],
            ),
          ],
        ),

        //product size details and more
        HStack(
          [
            //deliverable or not
            (product.canBeDelivered
                    ? "Deliverable".i18n
                    : "Not Deliverable".i18n)
                .text
                .white
                .sm
                .make()
                .py4()
                .px8()
                .box
                .roundedLg
                .color(
                  product.canBeDelivered ? Vx.green500 : Vx.red500,
                )
                .make(),

            //
            UiSpacer.expandedSpace(),

            //size
            "${product.capacity.numCurrency} ${product.unit}"
                .text
                .sm
                .black
                .make()
                .py4()
                .px8()
                .box
                .roundedLg
                .gray500
                .make()
                .pOnly(right: Vx.dp12),

            //package items
            "%s Items"
                .i18n
                .fill(["${product.packageCount}"])
                .text
                .sm
                .black
                .make()
                .py4()
                .px8()
                .box
                .roundedLg
                .gray500
                .make(),
          ],
        ).pOnly(top: Vx.dp10),
      ],
    ).px20().py12();
  }
}
