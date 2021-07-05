import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderAddressesView extends StatelessWidget {
  const OrderAddressesView(this.vm, {Key key}) : super(key: key);

  final OrderDetailsViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        Visibility(
          visible: vm.order.isPackageDelivery,
          child: VStack(
            [
              "Pickup Location".i18n.text.gray500.medium.sm.make(),
              "${vm.order.pickupLocation?.name}".text.xl.medium.make(),
              "${vm.order.pickupLocation?.address}"
                  .text
                  .make()
                  .pOnly(bottom: Vx.dp20),

              //stops
              ...(vm.order.orderStops.mapIndexed((stop, index){
                return VStack(
                  [
                    ("Stop".i18n+" ${index + 1}").text.gray500.medium.sm.make(),
                    "${stop.deliveryAddress?.name}".text.xl.medium.make(),
                    "${stop.deliveryAddress?.address}"
                        .text
                        .make()
                        .pOnly(bottom: Vx.dp20),
                  ],
                );
              }).toList()),

              //
              "Dropoff Location".i18n.text.gray500.medium.sm.make(),
              "${vm.order.dropoffLocation?.name}".text.xl.medium.make(),
              "${vm.order.dropoffLocation?.address}"
                  .text
                  .make()
                  .pOnly(bottom: Vx.dp20),
            ],
          ),
        ),

        //regular delivery address
        Visibility(
          visible: !vm.order.isPackageDelivery,
          child: VStack(
            [
              "Deliver To".i18n.text.gray500.medium.sm.make(),
              vm.order.deliveryAddress != null
                  ? vm.order.deliveryAddress.name.text.xl.medium.make()
                  : UiSpacer.emptySpace(),
              vm.order.deliveryAddress != null
                  ? vm.order.deliveryAddress.address.text
                      .make()
                      .pOnly(bottom: Vx.dp20)
                  : UiSpacer.emptySpace(),
            ],
          ),
        ),
      ],
    );
  }
}
