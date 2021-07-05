import 'package:flutter/material.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/views/pages/cart/widgets/amount_tile.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/order_product.list_item.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderDetailsItemsView extends StatelessWidget {
  const OrderDetailsItemsView(this.vm, {Key key}) : super(key: key);
  final OrderDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        (vm.order.isPackageDelivery ? "Package Details" : "Products")
            .i18n
            .text
            .gray500
            .semiBold
            .xl
            .make()
            .pOnly(bottom: Vx.dp10),
        vm.order.isPackageDelivery
            ? VStack(
                [
                  AmountTile(
                    "Package Type".i18n,
                    vm.order.packageType.name,
                  ),
                  AmountTile("Width".i18n, vm.order.width + "cm"),
                  AmountTile("Length".i18n, vm.order.length + "cm"),
                  AmountTile("Height".i18n, vm.order.height + "cm"),
                  AmountTile("Weight".i18n, vm.order.weight + "kg"),
                ],
                crossAlignment: CrossAxisAlignment.end,
              )
            : CustomListView(
                noScrollPhysics: true,
                dataSet: vm.order.orderProducts,
                itemBuilder: (context, index) {
                  //
                  final orderProduct = vm.order.orderProducts[index];
                  return OrderProductListItem(
                    orderProduct: orderProduct,
                  );
                },
              ),
      ],
    );
  }
}
