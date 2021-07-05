import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/checkout.vm.dart';
import 'package:fuodz/widgets/custom_grid_view.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:jiffy/jiffy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/checkout.i18n.dart';

class ScheduleOrderView extends StatelessWidget {
  const ScheduleOrderView(this.vm, {Key key}) : super(key: key);
  final CheckoutViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: vm.vendor.allowScheduleOrder,
      child: VStack(
        [
          HStack(
            [
              //
              Checkbox(
                value: vm.isScheduled,
                onChanged: vm.toggleScheduledOrder,
              ),
              //
              VStack(
                [
                  "Schedule Order".i18n.text.xl.semiBold.make(),
                  "If you want your order to be delivered/prepared at scheduled date/time"
                      .i18n
                      .text
                      .make(),
                ],
              ).expand(),
            ],
            crossAlignment: CrossAxisAlignment.start,
          ).wFull(context).onInkTap(
                () => vm.toggleScheduledOrder(!vm.isScheduled),
              ),

          //delivery time slots
          Visibility(
            visible: vm.isScheduled,
            child: VStack(
              [
                //date slot
                UiSpacer.verticalSpace(),
                "Date slot".i18n.text.lg.make(),
                CustomListView(
                  scrollDirection: Axis.horizontal,
                  dataSet: vm.vendor.deliverySlots,
                  itemBuilder: (context, index) {
                    final dateDeliverySlot = vm.vendor.deliverySlots[index];
                    final formmatedDeliverySlot =
                        Jiffy(dateDeliverySlot.date).format("yyyy-MM-dd");
                    bool selected =
                        formmatedDeliverySlot == vm.checkout.deliverySlotDate;
                    //
                    return Jiffy(dateDeliverySlot.date)
                        .format("EEEE dd MMM yyyy")
                        .text
                        .color(
                          selected ? Colors.white : null,
                        )
                        .makeCentered()
                        .px8()
                        .py4()
                        .box
                        .roundedSM
                        .border(color: AppColor.primaryColor)
                        .color(
                          selected ? AppColor.primaryColor : Colors.transparent,
                        )
                        .make()
                        .onInkTap(
                          () => vm.changeSelectedDeliveryDate(
                              formmatedDeliverySlot, index),
                        );
                  },
                ).h(Vx.dp32).py8(),
                //
                UiSpacer.verticalSpace(space: 10),
                "Time slot".i18n.text.lg.make(),
                UiSpacer.verticalSpace(space: 10),
                CustomGridView(
                  // scrollDirection: Axis.horizontal,
                  noScrollPhysics: true,
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  dataSet: vm.availableTimeSlots,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                  crossAxisCount: 3,
                  itemBuilder: (context, index) {
                    //
                    final availableTimeSlot = vm.availableTimeSlots[index];                  
                    final formmatedDeliveryTimeSlot =
                        Jiffy(availableTimeSlot,"hh:mm:ss").format("HH:mm:ss");
                    bool selected =
                        formmatedDeliveryTimeSlot == vm.checkout.deliverySlotTime;
                    //
                    return Jiffy(availableTimeSlot,"HH:mm:ss")
                        .format("hh:mm a")
                        .text
                        .color(
                          selected ? Colors.white : null,
                        )
                        .makeCentered()
                        .box
                        .roundedSM
                        .border(color: AppColor.primaryColor)
                        .color(
                          selected ? AppColor.primaryColor : Colors.transparent,
                        )
                        .make()
                        .onInkTap(
                          () => vm.changeSelectedDeliveryTime(
                            formmatedDeliveryTimeSlot,
                          ),
                        );
                  },
                ),
                // CustomGridView(dataSet: dataSet, itemBuilder: itemBuilder),
              ],
            ),
          ),
        ],
      ).p12().box.roundedSM.border(color: Colors.grey).make().pOnly(
            bottom: Vx.dp20,
          ),
    );
  }
}
