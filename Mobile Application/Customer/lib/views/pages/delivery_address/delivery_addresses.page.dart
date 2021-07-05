import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/delivery_address/delivery_addresses.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/translations/delivery_address/delivery_addresses.i18n.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/delivery_address.list_item.dart';
import 'package:fuodz/widgets/states/delivery_address.empty.dart';
import 'package:fuodz/widgets/states/error.state.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class DeliveryAddressesPage extends StatelessWidget {
  const DeliveryAddressesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeliveryAddressesViewModel>.reactive(
      viewModelBuilder: () => DeliveryAddressesViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: true,
          title: "Delivery Addresses".i18n,
          isLoading: vm.isBusy,
          fab: FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            child: Icon(
              FlutterIcons.plus_ant,
              color: Colors.white,
            ),
            onPressed: vm.newDeliveryAddressPressed,
          ),
          body: CustomListView(
            padding: EdgeInsets.fromLTRB(20,20,20,context.percentHeight * 20),
            dataSet: vm.deliveryAddresses,
            isLoading: vm.busy(vm.deliveryAddresses),
            emptyWidget: EmptyDeliveryAddress(),
            errorWidget: LoadingError(
              onrefresh: vm.fetchDeliveryAddresses,
            ),
            itemBuilder: (context, index) {
              //
              final deliveryAddress = vm.deliveryAddresses[index];
              //
              return DeliveryAddressListItem(
                deliveryAddress: deliveryAddress,
                onEditPressed: () => vm.editDeliveryAddress(deliveryAddress),
                onDeletePressed: () =>
                    vm.deleteDeliveryAddress(deliveryAddress),
              );
            },
            separatorBuilder: (context, index) =>
                UiSpacer.verticalSpace(space: 10),
          ),
        );
      },
    );
  }
}
