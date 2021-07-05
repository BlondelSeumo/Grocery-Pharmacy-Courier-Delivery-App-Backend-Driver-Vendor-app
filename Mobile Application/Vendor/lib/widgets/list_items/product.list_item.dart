import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({this.product, this.onPressed, Key key})
      : super(key: key);

  final Function(Product) onPressed;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        Stack(
          children: [
            //product image
            Hero(
              tag: product.heroTag,
              child: CustomImage(
                imageUrl: product.photo,
                boxFit: BoxFit.cover,
                width: context.percentWidth * 30,
                height: Vx.dp64 * 1.5,
              ).card.make(),
            ),

            //price
            Positioned(
              bottom: 0,
              right: 0,
              child: HStack(
                [
                  AppStrings.currencySymbol.text.white.make(),
                  product.showDiscount
                      ? "${product.price}"
                          .text
                          .sm
                          .lineThrough
                          .white
                          .make()
                          .px2()
                      : "${product.price}".text.xl.white.make(),
                  // discount price
                  product.showDiscount
                      ? "${product.discountPrice}".text.xl.white.make()
                      : UiSpacer.emptySpace(),
                ],
              ).py4().box.px8.rounded.color(AppColor.primaryColor).make(),
            ),
          ],
        ),

        //
        product.name.text.medium.lg
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .make(),
        product.vendor.name.text.sm
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .makeCentered(),
      ],
    ).centered().onInkTap(
          () => this.onPressed(this.product),
        );
  }
}
