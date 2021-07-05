import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/parcel_form_input.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';

class ParcelDeliveryStopsView extends StatelessWidget {
  const ParcelDeliveryStopsView(this.vm, {Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        //from
        ParcelFormInput(
          centered: true,
          iconData: FlutterIcons.car_ant,
          iconColor: Colors.green[700],
          labelText: "FROM".i18n,
          hintText: "Pickup Location".i18n,
          tec: vm.fromTEC,
          onInputTap: vm.changePickupAddress,
          formValidator: (value) => FormValidator.validateDeliveryAddress(
            value,
            errorTitle: "Pickup Location".i18n,
            deliveryaddress: vm.pickupLocation,
            vendor: vm.selectedVendor,
          ),
        ),
        UiSpacer.formVerticalSpace(),
        ...(getStopsInputs(context)),
        //
        CustomButton(
          title: "Add Stop".i18n,
          onPressed: !(AppStrings.maxParcelStops > (vm.toTECs.length - 1))
              ? null
              : vm.addNewStop,
        ).py12(),
      ],
    )
        .p12()
        .box
        .roundedSM
        .border(color: Colors.grey[300])
        .make()
        .pOnly(bottom: Vx.dp20);
  }

  ///
  List<Widget> getStopsInputs(BuildContext context) {
    List<Widget> stopsInput = [];

    //
    vm.toTECs.forEachIndexed((index, tec) {
      print("Index ==> $index");
      final lastStop = index == (vm.toTECs.length - 1);
      //
      final stopInput = ParcelFormInput(
        centered: true,
        icon: Icon(
          lastStop
              ? FlutterIcons.location_oct
              : FlutterIcons.location_arrow_faw,
          size: 20,
          color: lastStop ? Colors.red[700] : context.textTheme.bodyText1.color,
        ),
        hintText: "Where to ...".i18n,
        tec: tec,
        onInputTap: () => vm.changeStopDeliveryAddress(index),
        formValidator: (value) => FormValidator.validateEmpty(
          value,
          errorTitle: "Stop Location".i18n,
        ),
        suffix: vm.toTECs.length <= 1
            ? null
            : Icon(
                FlutterIcons.close_ant,
                color: context.textTheme.bodyText1.color,
                size: 18,
              )
                .onInkTap(
                  () => vm.removeStop(index),
                )
                .centered()
                .px4(),
      );

      //
      stopsInput.add(stopInput);
    });

    //
    return stopsInput;
  }
}
