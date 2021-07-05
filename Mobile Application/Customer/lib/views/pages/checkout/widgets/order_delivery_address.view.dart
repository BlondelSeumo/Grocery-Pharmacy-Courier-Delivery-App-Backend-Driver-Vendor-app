import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/view_models/checkout.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/list_items/delivery_address.list_item.dart';
import 'package:fuodz/widgets/states/delivery_address.empty.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/checkout.i18n.dart';

class OrderDeliveryAddressPickerView extends StatelessWidget {
  const OrderDeliveryAddressPickerView(this.vm, {Key key}) : super(key: key);
  final CheckoutViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        HStack(
          [
            //
            Checkbox(
              value: vm.isPickup,
              onChanged: vm.togglePickupStatus,
            ),
            //
            VStack(
              [
                "Pickup Order".i18n.text.xl.semiBold.make(),
                "Please indicate if you would come pickup order at the vendor"
                    .i18n
                    .text
                    .make(),
              ],
            ).expand(),
          ],
          crossAlignment: CrossAxisAlignment.start,
        ).wFull(context).onInkTap(
              () => vm.togglePickupStatus(!vm.isPickup),
            ),

        //

        //delivery address pick preview
        Visibility(
          visible: !vm.isPickup,
          child: VStack(
            [
              //divider
              Divider(thickness: 1).py4(),
              //
              HStack(
                [
                  //
                  VStack(
                    [
                      "Delivery address".i18n.text.semiBold.xl.make(),
                      "Please select delivery address/location"
                          .i18n
                          .text
                          .make(),
                    ],
                  ).expand(),
                  //
                  CustomButton(
                    title: "Change",
                    onPressed: vm.showDeliveryAddressPicker,
                  ),
                ],
              ),
              //Selected delivery address box
              DottedBorder(
                borderType: BorderType.RRect,
                color: context.accentColor,
                strokeWidth: 1,
                strokeCap: StrokeCap.round,
                radius: Radius.circular(5),
                dashPattern: [3, 6],
                child: vm.deliveryAddress != null
                    ? DeliveryAddressListItem(
                        deliveryAddress: vm.deliveryAddress,
                        action: false,
                        border: false,
                        showDefault: false,
                      )
                    : EmptyDeliveryAddress(selection: true)
                        .py12()
                        .opacity(value: 0.60),
              ).wFull(context).py12(),

              //within vendor range
              Visibility(
                visible: vm.delievryAddressOutOfRange,
                child: "Delivery address is out of vendor delivery range"
                    .i18n
                    .text
                    .sm
                    .red500
                    .make(),
              ),
            ],
          ),
        ),
      ],
    ).p12().box.roundedSM.border(color: Colors.grey).make().pOnly(
          bottom: Vx.dp20,
        );
  }
}
