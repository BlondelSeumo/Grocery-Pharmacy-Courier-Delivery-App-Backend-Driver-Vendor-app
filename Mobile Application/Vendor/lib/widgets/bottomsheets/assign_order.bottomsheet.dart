import 'package:flutter/material.dart';
import 'package:fuodz/view_models/assign_order.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class AssignOrderBottomSheet extends StatelessWidget {
  AssignOrderBottomSheet({Key key, this.onConfirm}) : super(key: key);

  final Function(int) onConfirm;

  //
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AssignOrderViewModel>.reactive(
      viewModelBuilder: () => AssignOrderViewModel(),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return SafeArea(
          child: VStack(
            [
              //
              "Assign Order To:".i18n.text.semiBold.xl.make(),
              //
              CustomListView(
                isLoading: vm.isBusy,
                dataSet: vm.drivers,
                itemBuilder: (context, index) {
                  //
                  final driver = vm.drivers[index];
                  return HStack(
                    [
                      //
                      Radio(
                        value: driver.id,
                        groupValue: vm.selectedDriverId,
                        onChanged: vm.changeSelectedDriver,
                      ),

                      //
                      "${driver.name}".text.lg.light.make().expand(),
                      //online/offline
                      "[${(driver.isOnline ? "Online".i18n : "Offline".i18n)}]"
                          .text
                          .color(driver.isOnline ? Colors.green : Colors.red)
                          .make(),
                    ],
                  )
                      .onInkTap(() => vm.changeSelectedDriver(driver.id))
                      .wFull(context);
                },
              ).py12(),

              //
              CustomButton(
                title: "Change".i18n,
                onPressed: () {
                  //
                  onConfirm(vm.selectedDriverId);
                },
              ),
            ],
          ).p20().scrollVertical().hTwoThird(context),
        );
      },
    );
  }
}
