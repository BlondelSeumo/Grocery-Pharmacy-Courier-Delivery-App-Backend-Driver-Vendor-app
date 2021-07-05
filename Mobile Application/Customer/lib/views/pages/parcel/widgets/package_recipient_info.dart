import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/form_step_controller.dart';
import 'package:fuodz/views/pages/parcel/widgets/parcel_form_input.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:fuodz/translations/new_parcel.i18n.dart';

class PackageRecipientInfo extends StatelessWidget {
  const PackageRecipientInfo({this.vm, Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: vm.recipientInfoFormKey,
      child: VStack(
        [
          //
          VStack(
            [
              //
              "Recipient Info".i18n.text.xl.medium.make().py20(),
              //name
              ParcelFormInput(
                isReadOnly: false,
                iconData: FlutterIcons.user_fea,
                iconColor: AppColor.primaryColor,
                labelText: "Name".i18n.toUpperCase(),
                hintText: "Name of recipient".i18n,
                tec: vm.recipientNameTEC,
                formValidator: (value) => FormValidator.validateCustom(
                  value,
                  name: "Name".i18n,
                ),
              ),
              UiSpacer.formVerticalSpace(),
              //phone
              ParcelFormInput(
                isReadOnly: false,
                iconData: FlutterIcons.phone_fea,
                iconColor: AppColor.primaryColor,
                labelText: "phone".i18n.toUpperCase(),
                hintText: "Phone number of recipient".i18n,
                keyboardType: TextInputType.phone,
                tec: vm.recipientPhoneTEC,
                formValidator: (value) => FormValidator.validatePhone(
                  value,
                  name: "phone".i18n.allWordsCapitilize(),
                ),
              ),
              UiSpacer.formVerticalSpace(),
              //note
              ParcelFormInput(
                isReadOnly: false,
                iconData: FlutterIcons.note_oct,
                iconColor: AppColor.primaryColor,
                labelText: "Note".i18n.toUpperCase(),
                hintText: "Further instruction".i18n,
                tec: vm.noteTEC,
              ),
            ],
          ).scrollVertical().expand(),

          //
          FormStepController(
            onPreviousPressed: () => vm.nextForm(2),
            onNextPressed: vm.validateRecipientInfo,
          ),
        ],
      ),
    );
  }
}
