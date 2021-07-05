import 'package:flutter/material.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/view_models/delivery_address/edit_delivery_addresses.vm.dart';
import 'package:fuodz/views/pages/delivery_address/widgets/what3words.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/delivery_address/edit_delivery_address.i18n.dart';

class EditDeliveryAddressesPage extends StatelessWidget {
  const EditDeliveryAddressesPage({
    this.deliveryAddress,
    Key key,
  }) : super(key: key);

  final DeliveryAddress deliveryAddress;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditDeliveryAddressesViewModel>.reactive(
      viewModelBuilder: () =>
          EditDeliveryAddressesViewModel(context, deliveryAddress),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: true,
          title: "Update Delivery Address".i18n,
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
                // (AppStrings.isWhat3wordsApiKey
                //         ? VStack(
                //             [
                //               CustomTextFormField(
                //                 labelText: "What3words " + "Name".i18n,
                //                 textEditingController: vm.what3wordsTEC,
                //                 validator: (value) =>
                //                     FormValidator.validateEmpty(
                //                   value,
                //                   errorTitle: "What3words " + "Name".i18n,
                //                 ),
                //                 onFieldSubmitted: vm.validateWhat3words,
                //               ),
                //               //
                //               "Get What3words name from this link"
                //                   .i18n
                //                   .text
                //                   .sm
                //                   .underline
                //                   .make()
                //                   .py2()
                //                   .onInkTap(vm.shareWhat3words),
                //             ],
                //           )
                //         : UiSpacer.emptySpace())
                //     .py16(),
                //
                CustomTextFormField(
                  labelText: "Address".i18n,
                  isReadOnly: true,
                  textEditingController: vm.addressTEC,
                  validator: (value) => FormValidator.validateEmpty(
                    value,
                    errorTitle: "Address".i18n,
                  ),
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
                  onPressed: vm.updateDeliveryAddress,
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
