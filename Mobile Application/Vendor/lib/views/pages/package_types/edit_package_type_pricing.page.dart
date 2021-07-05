import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fuodz/models/package_type_pricing.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/manage_package_type_pricing.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/pricing.i18n.dart';

class EditPackagePricingPage extends StatelessWidget {
  const EditPackagePricingPage(this.packageTypePricing, {Key key})
      : super(key: key);

  final PackageTypePricing packageTypePricing;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManagePackageTypePricingViewModel>.reactive(
      viewModelBuilder: () => ManagePackageTypePricingViewModel(
        context,
        packageTypePricing,
      ),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          title: "Edit Package Type Pricing".i18n,
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
                            initialValue: packageTypePricing.packageTypeId,
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
                      initialValue:
                          packageTypePricing.maxBookingDays.toString(),
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
                      initialValue: packageTypePricing.basePrice.toString(),
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
                      initialValue: packageTypePricing.sizePrice.toString(),
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
                      initialValue: packageTypePricing.distancePrice.toString(),
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
                      name: 'price_per_kg',
                      initialValue: packageTypePricing.pricePerKg == 1,
                      onChanged: (value) {},
                      title: "Charge per KG".i18n.text.make(),
                    ),
                    //km/distance charge
                    FormBuilderCheckbox(
                      name: 'price_per_km',
                      initialValue: packageTypePricing.pricePerKm == 1,
                      onChanged: (value) {},
                      title: "Charge per KM".i18n.text.make(),
                    ),
                    //auto_ready
                    FormBuilderCheckbox(
                      name: 'auto_assignment',
                      initialValue: packageTypePricing.autoReady,
                      onChanged: (value) {},
                      title: "Auto move to ready".i18n.text.make(),
                    ),
                    //extra_fields
                    FormBuilderCheckbox(
                      name: 'field_required',
                      initialValue: packageTypePricing.extraFields,
                      onChanged: (value) {},
                      title:
                          "Extra fields required (e.g kg, width)".i18n.text.make(),
                    ),
                    //Active
                    FormBuilderCheckbox(
                      name: 'is_active',
                      initialValue: packageTypePricing.isActive == 1,
                      onChanged: (value) {},
                      title: "Active".i18n.text.make(),
                    ),
                    //
                    CustomButton(
                      title: "Update Pricing".i18n,
                      loading: vm.isBusy,
                      onPressed: vm.processUpdate,
                    ).centered().py12(),
                  ],
                ),
              ).p20().scrollVertical()),
        );
      },
    );
  }
}
