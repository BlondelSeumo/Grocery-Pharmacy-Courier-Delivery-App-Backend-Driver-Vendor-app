import 'package:flutter/material.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/product.i18n.dart';

class ManageProductListItem extends StatelessWidget {
  //
  const ManageProductListItem(this.product,
      {this.isLoading = false,
      this.onPressed,
      this.onEditPressed,
      this.onToggleStatusPressed,
      this.onDeletePressed,
      Key key})
      : super(key: key);

  //
  final Product product;
  final bool isLoading;
  final Function(Product) onPressed;
  final Function(Product) onEditPressed;
  final Function(Product) onToggleStatusPressed;
  final Function(Product) onDeletePressed;
  @override
  Widget build(BuildContext context) {
    //
    final currencySymbol = AppStrings.currencySymbol;

    //
    return VStack(
      [
        //
        HStack(
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
                "${product.description}"
                    .text
                    .sm
                    .medium
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
              ],
            ),
          ],
        ),
        //actions
        HStack(
          [
            //
            CustomButton(
              loading: isLoading,
              height: 30,
              title: "Edit",
              onPressed: () => onEditPressed(product),
              color: Colors.grey,
            ).px12(),
            CustomButton(
              loading: isLoading,
              height: 30,
              title: (product.isActive != 1 ? "Activate" : "Deactivate").i18n,
              onPressed: () => onToggleStatusPressed(product),
              color: product.isActive != 1 ? Colors.green : Colors.red[400],
            ).px12(),
            CustomButton(
              loading: isLoading,
              height: 30,
              title: "Delete".i18n,
              onPressed: () => onDeletePressed(product),
              color: Colors.red,
            ).px12(),
          ],
          alignment: MainAxisAlignment.spaceEvenly,
          crossAlignment: CrossAxisAlignment.center,
        ),
        //
      ],
    ).p8().onInkTap(() => onPressed(product)).card.make();
  }
}
