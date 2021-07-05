import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/form_step_controller.dart';
import 'package:fuodz/views/pages/parcel/widgets/parcel_schedule.view.dart';
import 'package:fuodz/views/pages/parcel/widgets/parcel_stops.view.dart';
import 'package:fuodz/views/pages/parcel/widgets/single_parcel_stop.view.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';

class PackageDeliveryInfo extends StatelessWidget {
  const PackageDeliveryInfo({this.vm, Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: vm.deliveryInfoFormKey,
      child: VStack(
        [
          //
          VStack(
            [
              "Delivery Info".i18n.text.xl.medium.make().py20(),
              Visibility(
                visible: !AppStrings.enableParcelMultipleStops,
                child: SingleParcelDeliveryStopsView(vm),
              ),
              Visibility(
                visible: AppStrings.enableParcelMultipleStops,
                child: ParcelDeliveryStopsView(vm),
              ),

              //ParcelScheduleView
              ParcelScheduleView(vm),
              //SCHEDULE
              Visibility(
                visible: !vm.selectedVendor.allowScheduleOrder,
                child: VStack(
                  [
                    "DATE & TIME".i18n.text.make(),
                    "Vendor does not allow order scheduling. So you order will be processed as soon as you place them".i18n
                        .text
                        .color(context.textTheme.bodyText1.color)
                        .sm
                        .make(),
                  ],
                ),
              ),
            ],
          ).scrollVertical().expand(),

          //
          FormStepController(
            onPreviousPressed: () => vm.nextForm(
              AppStrings.enableSingleVendor ? 0 : 1,
            ),
            onNextPressed: vm.validateDeliveryInfo,
          ),
        ],
      ),
    );
  }
}
