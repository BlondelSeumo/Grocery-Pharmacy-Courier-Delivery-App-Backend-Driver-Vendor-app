import 'package:flutter/material.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/form_step_controller.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';

class PackageDeliveryParcelInfo extends StatelessWidget {
  const PackageDeliveryParcelInfo({this.vm, Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: vm.packageInfoFormKey,
      child: VStack(
        [
          //
          VStack(
            [
              "Package Parameters".i18n.text.xl.medium.make().py20(),
              //
              ("Weight".i18n + " (kg)").text.make(),
              CustomTextFormField(
                underline: true,
                hintText: "Enter package weight".i18n,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: vm.packageWeightTEC,
                validator: (value) => FormValidator.validateCustom(
                  value,
                  name: "Weight".i18n,
                  rules: vm.requireParcelInfo ? "required|gt:0":''
                ),
              ),
              UiSpacer.formVerticalSpace(),
              //
              ("Length".i18n + " (cm)").text.make(),
              CustomTextFormField(
                underline: true,
                hintText: "Enter package length".i18n,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: vm.packageLengthTEC,
                validator: (value) => FormValidator.validateCustom(
                  value,
                  name: "Length".i18n,
                  rules: vm.requireParcelInfo ?"required|gt:0":''
                ),
              ),
              UiSpacer.formVerticalSpace(),
              //
              //
              ("Width".i18n + " (cm)").text.make(),
              CustomTextFormField(
                underline: true,
                hintText: "Enter package width".i18n,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textEditingController: vm.packageWidthTEC,
                validator: (value) => FormValidator.validateCustom(
                  value,
                  name: "Width".i18n,
                  rules: vm.requireParcelInfo ?"required|gt:0":''
                ),
              ),
              UiSpacer.formVerticalSpace(),

              //
              ("Height".i18n + " (cm)").text.make(),
              CustomTextFormField(
                underline: true,
                hintText: "Enter package height".i18n,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                textEditingController: vm.packageHeightTEC,
                validator: (value) => FormValidator.validateCustom(
                  value,
                  name: "Height".i18n,
                  rules: vm.requireParcelInfo ?"required|gt:0":''
                ),
              ),

              //finish btn
              UiSpacer.formVerticalSpace(),
            ],
          ).scrollVertical().expand(),

          //
          FormStepController(
            onPreviousPressed: () => vm.nextForm(3),
            onNextPressed: vm.validateDeliveryParcelInfo,
          ),
        ],
      ),
    );
  }
}
