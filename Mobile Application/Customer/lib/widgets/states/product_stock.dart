import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/product_details.i18n.dart';

class ProductStockState extends StatelessWidget {
  const ProductStockState(this.product, {this.qtyUpdated, Key key})
      : super(key: key);

  final Product product;
  final Function qtyUpdated;
  @override
  Widget build(BuildContext context) {
    // return "${product.availableQty}".text.make();
    return (AppStrings.enableGroceryMode && product.hasStock)
        ? VxStepper(
            disableInput: true,
            max: product.availableQty ?? 20,
            onChange: (qty) => qtyUpdated(product, qty),
          ).py4().centered()
        : !product.hasStock
            ? "No stock"
                .i18n
                .text
                .white
                .makeCentered()
                .py2()
                .px4()
                .box
                .red600
                .roundedSM
                .make()
                .p8()
            : UiSpacer.emptySpace();
  }
}
