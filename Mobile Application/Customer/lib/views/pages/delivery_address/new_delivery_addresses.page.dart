import 'package:flutter/material.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/view_models/delivery_address/new_delivery_addresses.vm.dart';
import 'package:fuodz/views/pages/delivery_address/widgets/what3words.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/translations/delivery_address/new_delivery_address.i18n.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class NewDeliveryAddressesPage extends StatelessWidget {
  const NewDeliveryAddressesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewDeliveryAddressesViewModel>.reactive(
      viewModelBuilder: () => NewDeliveryAddressesViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: true,
          title: "New Delivery Address".i18n,
          body: Form(
            key: vm.formKey,
            child: VStack(
              [
                //
                CustomTextFormField(
                  labelText: "Name".i18n,
                  textEditingController: vm.nameTEC,
                  validator: FormValidator.validateName,
                ),
                //what3words
                What3wordsView(vm),
                //
                CustomTextFormField(
                  labelText: "Address".i18n,
                  isReadOnly: true,
                  textEditingController: vm.addressTEC,
                  validator: (value) => FormValidator.validateEmpty(value,
                      errorTitle: "Address".i18n),
                  onTap: vm.openLocationPicker,
                ).py2(),
                //
                HStack(
                  [
                    Checkbox(
                      value: vm.isDefault,
                      onChanged: vm.toggleDefault,
                    ),
                    //
                    "Default".i18n.text.make(),
                  ],
                )
                    .onInkTap(
                      () => vm.toggleDefault(!vm.isDefault),
                    )
                    .wFull(context)
                    .py12(),

                CustomButton(
                  isFixedHeight: true,
                  height: Vx.dp48,
                  title: "Save".i18n,
                  onPressed: vm.saveNewDeliveryAddress,
                  loading: vm.isBusy,
                ).centered(),
              ],
            ).p20().scrollVertical(),
          ),
        );
      },
    );
  }
}
