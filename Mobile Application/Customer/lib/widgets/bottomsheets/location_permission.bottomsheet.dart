import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/delivery_address_picker.i18n.dart';

class LocationPermissionDialog extends StatelessWidget {
  const LocationPermissionDialog({Key key, this.onResult}) : super(key: key);

  //
  final Function(bool) onResult;

  //
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: VStack(
        [
          //title
          "Location Permission Request".i18n.text.semiBold.xl.make().py12(),
          ("${AppStrings.appName} " +
                  "requires your location permission to show you nearby vendors, setup delivery address/location during checkout and Live tracking of Order and Delivery Persons"
                      .i18n)
              .text
              .make(),
          UiSpacer.verticalSpace(),
          CustomButton(
            title: "Request Permission".i18n,
            onPressed: () {
              onResult(true);
              AppService.navigatorKey.currentContext.pop();
            },
          ).py12(),
          CustomButton(
            title: "Cancel".i18n,
            color: Colors.grey[400],
            onPressed: () {
              onResult(false);
              AppService.navigatorKey.currentContext.pop();
            },
          ),
        ],
      ).p20().wFull(context).scrollVertical(), //.hTwoThird(context),
    );
  }
}
