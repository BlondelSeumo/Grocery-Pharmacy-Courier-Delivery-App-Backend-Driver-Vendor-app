import 'package:flutter/material.dart';
import 'package:fuodz/models/order_product.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderProductListItem extends StatelessWidget {
  const OrderProductListItem({
    this.orderProduct,
    Key key,
  }) : super(key: key);

  final OrderProduct orderProduct;
  @override
  Widget build(BuildContext context) {
    return HStack(
          [
            //vendor image
            CustomImage(
              imageUrl: orderProduct?.product?.photo ?? "",
              width: context.percentWidth * 20,
              boxFit: BoxFit.cover,
              height: context.percentHeight * 12,
            ),

            //
            VStack(
              [
                //
                orderProduct.product.name.text.xl.medium.make(),
                orderProduct.options != null ? orderProduct.options.text.sm.gray500.medium.make(): UiSpacer.emptySpace(),
                "${AppStrings.currencySymbol}${orderProduct.price.numCurrency}".text.lg.make(),
              ],
            ).p12().expand(),

            //qty
            "x ${orderProduct.quantity}".text.xl.medium.make().px12(),
          ],
        ).card.elevation(1).clip(Clip.antiAlias).roundedSM.make();

     
  }
}
