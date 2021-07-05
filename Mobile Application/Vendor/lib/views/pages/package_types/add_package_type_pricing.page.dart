import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/manage_package_type_pricing.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/pricing.i18n.dart';

class NewPackagePricingPage extends StatelessWidget {
  const NewPackagePricingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManagePackageTypePricingViewModel>.reactive(
      viewModelBuilder: () => ManagePackageTypePricingViewModel(context, null),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          title: "New Package Type Pricing".i18n,
          body: SafeArea(
              top: true,
              bottom: false,
              child: FormBuilder(
                key: vm.formBuilderKey,
                child: VStack(
                  [
                    //package types
                    vm.busy(vm.packageTypes)
                        ? BusyIndicator().centered()
                        : FormBuilderDropdown(
                            name: 'package_type_id',
                            decoration: InputDecoration(
                              labelText: 'Package Type'.i18n,
                            ),
                            // initialValue: 'Male',
                            allowClear: true,
                            hint: Text('Select Package Type'.i18n),
                            validator: FormBuilderValidators.compose(
                              [
                                FormBuilderValidators.required(context),
                              ],
                            ),
                            items: vm.packageTypes
                                .map(
                                  (packageType) => DropdownMenuItem(
                                    value: packageType.id,
                                    child: '${packageType.name}'.text.make(),
                                  ),
                                )
                                .toList(),
                          ),
                    UiSpacer.verticalSpace(),
                    //max_booking_days
                    FormBuilderTextField(
                      name: 'max_booking_days',
                      decoration: InputDecoration(
                        labelText: 'Max booking days'.i18n,
                      ),
                      onChanged: (value) {},
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    UiSpacer.verticalSpace(),
                    //base price
                    FormBuilderTextField(
                      name: 'base_price',

                      decoration: InputDecoration(
                        labelText: 'Base Price'.i18n,
                      ),
                      onChanged: (value) {},
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                    ),
                    UiSpacer.verticalSpace(),
                    //package price
                    FormBuilderTextField(
                      name: 'size_price',

                      decoration: InputDecoration(
                        labelText: 'Package Price'.i18n,
                      ),
                      onChanged: (value) {},
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                    ),
                    UiSpacer.verticalSpace(),
                    //distance price
                    FormBuilderTextField(
                      name: 'distance_price',

                      decoration: InputDecoration(
                        labelText: 'Distance Price'.i18n,
                      ),
                      onChanged: (value) {},
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                    ),
                    //
                    UiSpacer.verticalSpace(),
                    //kg charge
                    FormBuilderCheckbox(
                      initialValue: false,
                      name: 'price_per_kg',
                      onChanged: (value) {},
                      title: "Charge per KG".i18n.text.make(),
                    ),
                    //km/distance charge
                    FormBuilderCheckbox(
                      initialValue: false,
                      name: 'price_per_km',
                      onChanged: (value) {},
                      title: "Charge per KM".i18n.text.make(),
                    ),
                    //auto_ready
                    FormBuilderCheckbox(
                      initialValue: false,
                      name: 'auto_assignment',
                      onChanged: (value) {},
                      title: "Auto move to ready".i18n.text.make(),
                    ),
                    //extra_fields
                    FormBuilderCheckbox(
                      initialValue: false,
                      name: 'field_required',
                      onChanged: (value) {},
                      title:
                          "Extra fields required (e.g kg, width)".i18n.text.make(),
                    ),
                    //Active
                    FormBuilderCheckbox(
                      initialValue: true,
                      name: 'is_active',
                      onChanged: (value) {},
                      title: "Active".i18n.text.make(),
                    ),
                    //
                    CustomButton(
                      title: "Save Pricing".i18n,
                      loading: vm.isBusy,
                      onPressed: vm.processNewPricing,
                    ).centered().py12(),
                  ],
                ),
              ).p20().scrollVertical()),
        );
      },
    );
  }
}
