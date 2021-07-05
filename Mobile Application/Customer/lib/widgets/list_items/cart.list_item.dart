import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/models/cart.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class CartListItem extends StatelessWidget {
  const CartListItem(
    this.cart, {
    this.onQuantityChange,
    this.deleteCartItem,
    Key key,
  }) : super(key: key);

  final Cart cart;
  final Function(int) onQuantityChange;
  final Function deleteCartItem;

  @override
  Widget build(BuildContext context) {
    //
    final currencySymbol = AppStrings.currencySymbol;

    return HStack(
      [
        //
        //PRODUCT IMAGE
        CustomImage(
          imageUrl: cart.product.photo,
          width: context.percentWidth * 18,
          height: context.percentWidth * 18,
        ).box.clip(Clip.antiAlias).roundedSM.make(),

        //
        UiSpacer.horizontalSpace(),
        VStack(
          [
            //product name
            cart.product.name.text.semiBold.xl.make(),
            UiSpacer.verticalSpace(space: 0),
            //product options
            cart.optionsSentence.isNotEmpty
                ? cart.optionsSentence.text.lg.gray600.medium.make()
                : UiSpacer.emptySpace(),
            cart.optionsSentence.isNotEmpty
                ? UiSpacer.verticalSpace(space: 10)
                : UiSpacer.verticalSpace(space: 5),
            //
            VxStepper(
              defaultValue: cart.selectedQty ?? 1,
              min: 1,
              max: cart.product.availableQty ?? 20,
              disableInput: true,
              onChange: onQuantityChange,
            ),
          ],
        ).expand(),

        //
        UiSpacer.horizontalSpace(),
        VStack(
          [
            //delete icon
            Icon(
              FlutterIcons.delete_ant,
              size: 16,
              color: Colors.white,
            )
                .centered()
                .p8()
                .onInkTap(
                  this.deleteCartItem,
                )
                .box
                .roundedFull
                .color(Colors.red)
                .make(),

            //cart item price
            UiSpacer.verticalSpace(),
            "$currencySymbol ${(cart.selectedQty * cart.price).numCurrency}"
                .text
                .semiBold
                .xl
                .make(),
          ],
          crossAlignment: CrossAxisAlignment.end,
        )
      ],
    );
  }
}
