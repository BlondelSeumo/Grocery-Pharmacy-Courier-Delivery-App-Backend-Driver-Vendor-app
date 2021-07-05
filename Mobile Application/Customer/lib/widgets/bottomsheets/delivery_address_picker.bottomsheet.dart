import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/delivery_address/delivery_addresses_picker.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/delivery_address.list_item.dart';
import 'package:fuodz/translations/delivery_address_picker.i18n.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class DeliveryAddressPicker extends StatelessWidget {
  const DeliveryAddressPicker(
      {this.onSelectDeliveryAddress, this.allowOnMap = false, Key key})
      : super(key: key);

  final Function(DeliveryAddress) onSelectDeliveryAddress;
  final bool allowOnMap;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeliveryAddressPickerViewModel>.reactive(
      viewModelBuilder: () =>
          DeliveryAddressPickerViewModel(context, onSelectDeliveryAddress),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return VStack(
          [
            //
            HStack(
              [
                //
                VStack(
                  [
                    "Delivery address".i18n.text.make(),
                    "Select order delivery address".i18n.text.make(),
                  ],
                ).expand(),

                //
                AuthServices.authenticated()
                    ? CustomButton(
                        title: "New".i18n,
                        icon: FlutterIcons.plus_ant,
                        onPressed: vm.newDeliveryAddressPressed,
                      )
                    : UiSpacer.emptySpace(),
              ],
            ).p16().box.outerShadow.color(context.cardColor).make(),

            //
            vm.isBusy ||
                    (vm.deliveryAddresses != null &&
                        vm.deliveryAddresses.isNotEmpty)
                ? CustomListView(
                    dataSet: vm.deliveryAddresses,
                    isLoading: vm.isBusy,
                    padding: EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      //
                      final deliveryAddress = vm.deliveryAddresses[index];
                      return DeliveryAddressListItem(
                        deliveryAddress: deliveryAddress,
                        action: false,
                      ).onInkTap(
                        () => this.onSelectDeliveryAddress(deliveryAddress),
                      );
                    },
                  ).expand()
                : UiSpacer.emptySpace(),

            //
            allowOnMap
                ? SafeArea(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(alignment: Alignment.center),
                      label: "Choose on map".i18n.text.make(),
                      icon: Icon(FlutterIcons.location_pin_ent),
                      onPressed: vm.pickFromMap,
                    ).wFull(context).px20(),
                  )
                : UiSpacer.emptySpace(),
          ],
        ).hTwoThird(context);
      },
    );
  }
}
