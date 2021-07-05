import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/widgets/custom_grid_view.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:jiffy/jiffy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';

class ParcelScheduleView extends StatelessWidget {
  const ParcelScheduleView(this.vm, {Key key}) : super(key: key);
  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: vm.selectedVendor.allowScheduleOrder,
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
                  dataSet: vm.selectedVendor.deliverySlots,
                  itemBuilder: (context, index) {
                    final dateDeliverySlot = vm.selectedVendor.deliverySlots[index];
                    final formmatedDeliverySlot =
                        Jiffy(dateDeliverySlot.date).format("yyyy-MM-dd");
                    bool selected =
                        formmatedDeliverySlot == vm.packageCheckout.deliverySlotDate;
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
                        Jiffy(availableTimeSlot, "hh:mm:ss").format("HH:mm:ss");
                    bool selected = formmatedDeliveryTimeSlot ==
                        vm.packageCheckout.deliverySlotTime;
                    //
                    return Jiffy(availableTimeSlot, "HH:mm:ss")
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
      ).p12().box.roundedSM.border(color: Colors.grey[300]).make().pOnly(
            bottom: Vx.dp20,
          ),
    );
    // return VStack(
    //   [
    //     //date
    //     ParcelFormInput(
    //       iconData: FlutterIcons.calendar_ant,
    //       iconColor: AppColor.primaryColorDark,
    //       labelText: "DATE".i18n,
    //       hintText: "select".i18n,
    //       tec: vm.dateTEC,
    //       onInputTap: vm.changeDropOffDate,
    //       formValidator: (value) => FormValidator.validateEmpty(
    //         value,
    //         errorTitle: "DATE".i18n,
    //       ),
    //     ),
    //     UiSpacer.formVerticalSpace(),

    //     //time
    //     ParcelFormInput(
    //       iconData: FlutterIcons.clock_fea,
    //       iconColor: AppColor.primaryColorDark,
    //       labelText: "TIME".i18n,
    //       hintText: "select".i18n,
    //       tec: vm.timeTEC,
    //       onInputTap: vm.changeDropOffTime,
    //       formValidator: (value) => FormValidator.validateEmpty(
    //         value,
    //         errorTitle: "TIME".i18n,
    //       ),
    //     ),
    //   ],
    // );
  }
}
