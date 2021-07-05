import 'package:flutter/material.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/states/product_stock.dart';
import 'package:velocity_x/velocity_x.dart';

class HorizontalProductListItem extends StatelessWidget {
  //
  const HorizontalProductListItem(this.product,
      {this.onPressed, @required this.qtyUpdated, Key key})
      : super(key: key);

  //
  final Product product;
  final Function(Product) onPressed;
  final Function(Product, int) qtyUpdated;
  @override
  Widget build(BuildContext context) {
    //
    final currencySymbol = AppStrings.currencySymbol;

    //
    return HStack(
      [
        //
        Hero(
          tag: product.heroTag,
          child: CustomImage(imageUrl: product.photo)
              .wh(Vx.dp64, Vx.dp64)
              .box
              .clip(Clip.antiAlias)
              .roundedSM
              .make(),
        ),

        //Details
        VStack(
          [
            //name
            product.name.text.lg.medium
                .maxLines(2)
                .overflow(TextOverflow.ellipsis)
                .make(),
            //description
            product.description.text.sm.medium
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .make(),
          ],
        ).px12().expand(),

        //
        VStack(
          [
            //price
            HStack(
              [
                currencySymbol.text.lg.make(),
                (product.showDiscount
                        ? product.discountPrice.numCurrency
                        : product.price.numCurrency)
                    .text
                    .xl
                    .semiBold
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

            // plus/min icon here
            ProductStockState(product, qtyUpdated: qtyUpdated),
          ],
          crossAlignment: CrossAxisAlignment.end,
        ),
      ],
    )
        .onInkTap(() => onPressed(product))
        .box
        .p4
        .roundedSM
        .color(context.cardColor)
        .outerShadow
        .makeCentered()
        .p8();
  }
}
