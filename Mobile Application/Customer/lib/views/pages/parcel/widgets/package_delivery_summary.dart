import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/form_step_controller.dart';
import 'package:fuodz/widgets/list_items/package_type.list_item.dart';
import 'package:fuodz/widgets/list_items/parcel_vendor.list_item.dart';
import 'package:velocity_x/velocity_x.dart';

class PackageDeliverySummary extends StatelessWidget {
  const PackageDeliverySummary({this.vm, Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        VStack(
          [
            //
            "Summary".i18n.text.xl2.semiBold.make().py20(),
            //package type
            "Package Type".text.xl.medium.make().py8(),
            PackageTypeListItem(packageType: vm.selectedPackgeType),
            UiSpacer.formVerticalSpace(),
            //
            "Courier Vendor".text.xl.medium.make().py8(),
            ParcelVendorListItem(vm.selectedVendor),
            UiSpacer.formVerticalSpace(),

            //
            "Delivery Details".text.xl.medium.make().py8(),
            VStack(
              [
                "FROM".i18n.text.semiBold.make(),
                vm.pickupLocation.address.text.make().pOnly(bottom: Vx.dp4),
                UiSpacer.verticalSpace(space: 10),
                //dropoff location
                Visibility(
                  visible: !AppStrings.enableParcelMultipleStops,
                  child: VStack(
                    [
                      "TO".i18n.text.semiBold.make(),
                      vm.dropoffLocation.address.text.make(),
                      UiSpacer.verticalSpace(space: 10),
                    ],
                  ),
                ),

                //stops
                Visibility(
                  visible: AppStrings.enableParcelMultipleStops,
                  child: (vm.packageCheckout.stopsLocation != null)
                      ? VStack(
                          [
                            ...(vm.packageCheckout.stopsLocation
                                .mapIndexed((stop, index) {
                              return VStack(
                                [
                                  ("Stop".i18n + " ${index + 1}")
                                      .text
                                      .semiBold
                                      .make(),
                                  "${stop?.address}".text.make(),
                                  UiSpacer.verticalSpace(space: 10),
                                ],
                              );
                            }).toList()),
                          ],
                        )
                      : UiSpacer.emptySpace(),
                ),

                //
                UiSpacer.verticalSpace(space: 10),
                HStack(
                  [
                    //date
                    VStack(
                      [
                        "DATE".i18n.text.semiBold.make(),
                        (vm.pickupDate != null ? vm.pickupDate : "ASAP".i18n)
                            .text
                            .make(),
                      ],
                    ).expand(),
                    UiSpacer.horizontalSpace(),
                    //time
                    VStack(
                      [
                        "TIME".i18n.text.semiBold.make(),
                        (vm.pickupTime != null ? vm.pickupTime : "ASAP".i18n)
                            .text
                            .make(),
                      ],
                    ).expand(),
                  ],
                ),
              ],
            )
                .p12()
                .box
                .roundedSM
                .border(color: Colors.grey[300], width: 2)
                .make(),
            UiSpacer.formVerticalSpace(),

            //
            "Recipient Info".text.xl.medium.make().py8(),
            HStack(
              [
                VStack(
                  [
                    "Name".i18n.text.semiBold.make(),
                    vm.recipientNameTEC.text.text.make(),
                  ],
                ).expand(),
                UiSpacer.horizontalSpace(),
                VStack(
                  [
                    "phone".i18n.allWordsCapitilize().text.semiBold.make(),
                    vm.recipientPhoneTEC.text.text.make(),
                  ],
                ).expand(),
              ],
            )
                .p12()
                .box
                .roundedSM
                .border(color: Colors.grey[300], width: 2)
                .make()
                .wFull(context),
            UiSpacer.formVerticalSpace(),

            //
            "Package Parameters".text.xl.medium.make().py8(),
            VStack(
              [
                HStack(
                  [
                    //weight
                    VStack(
                      [
                        "Weight".i18n.text.semiBold.make(),
                        "${vm.packageWeightTEC.text}kg".text.make(),
                      ],
                    ).expand(),
                    //length
                    VStack(
                      [
                        "Length".i18n.text.semiBold.make(),
                        "${vm.packageLengthTEC.text}cm".text.make(),
                      ],
                    ).expand(),
                  ],
                ),
                UiSpacer.verticalSpace(space: 10),
                HStack(
                  [
                    //width
                    VStack(
                      [
                        "Width".i18n.text.semiBold.make(),
                        "${vm.packageWidthTEC.text}cm".text.make(),
                      ],
                    ).expand(),
                    //time
                    VStack(
                      [
                        "Height".i18n.text.semiBold.make(),
                        "${vm.packageHeightTEC.text}cm".text.make(),
                      ],
                    ).expand(),
                  ],
                ),
              ],
            )
                .p12()
                .box
                .roundedSM
                .border(color: Colors.grey[300], width: 2)
                .make()
                .wFull(context),
            UiSpacer.formVerticalSpace(),
          ],
        ).scrollVertical().expand(),

        //
        FormStepController(
          onPreviousPressed: () => vm.nextForm(4),
          onNextPressed: vm.prepareOrderSummary,
        ),
      ],
    );
  }
}
