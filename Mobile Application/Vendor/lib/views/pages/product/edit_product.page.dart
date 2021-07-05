import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/edit_products.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/cards/image_selector.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/product.i18n.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage(this.product, {Key key}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProductViewModel>.reactive(
      viewModelBuilder: () => EditProductViewModel(context, product),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showLeadingAction: true,
          showAppBar: true,
          title: "Edit Product".i18n,
          body: SafeArea(
            top: true,
            bottom: false,
            child: FormBuilder(
              key: vm.formBuilderKey,
              child: VStack(
                [
                  //name
                  FormBuilderTextField(
                    name: 'name',
                    initialValue: product.name,
                    decoration: InputDecoration(
                      labelText: 'Name'.i18n,
                    ),
                    onChanged: (value) {},
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  UiSpacer.verticalSpace(),
                  //image
                  ImageSelectorView(
                    imageUrl: product.photo,
                    onImageselected: vm.onImageselected,
                  ),
                  UiSpacer.verticalSpace(),
                  //description
                  FormBuilderTextField(
                    name: 'description',
                    initialValue: product.description,
                    decoration: InputDecoration(
                      labelText: 'Description'.i18n,
                    ),
                    onChanged: (value) {},
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    maxLines: 3,
                    textInputAction: TextInputAction.newline,
                  ),
                  UiSpacer.verticalSpace(),
                  //pricing
                  HStack(
                    [
                      //price
                      FormBuilderTextField(
                        name: 'price',
                        initialValue: product.price.toString(),
                        decoration: InputDecoration(
                          labelText: 'Price'.i18n,
                        ),
                        onChanged: (value) {},
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.numeric(context),
                        ]),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                      ).expand(),
                      UiSpacer.horizontalSpace(),
                      //Discount price
                      FormBuilderTextField(
                        name: 'discount_price',
                        initialValue: product.discountPrice.toString(),
                        decoration: InputDecoration(
                          labelText: 'Discount Price'.i18n,
                        ),
                        onChanged: (value) {},
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.numeric(context),
                        ]),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                      ).expand(),
                    ],
                  ),
                  //
                  UiSpacer.verticalSpace(),
                  //packaging
                  HStack(
                    [
                      //Capacity
                      FormBuilderTextField(
                        name: 'capacity',
                        initialValue: product.capacity,
                        decoration: InputDecoration(
                          labelText: 'Capacity'.i18n,
                        ),
                        onChanged: (value) {},
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.numeric(context),
                        ]),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                      ).expand(),
                      UiSpacer.horizontalSpace(),
                      //unit
                      FormBuilderTextField(
                        name: 'unit',
                        initialValue: product.unit,
                        decoration: InputDecoration(
                          labelText: 'Unit'.i18n,
                        ),
                        onChanged: (value) {},
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ).expand(),
                    ],
                  ),
                  //
                  UiSpacer.verticalSpace(),
                  //pricing
                  HStack(
                    [
                      //package_count
                      FormBuilderTextField(
                        name: 'package_count',
                        initialValue: product.packageCount,
                        decoration: InputDecoration(
                          labelText: 'Package Count'.i18n,
                        ),
                        onChanged: (value) {},
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                          FormBuilderValidators.numeric(context),
                        ]),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                      ).expand(),
                      UiSpacer.horizontalSpace(),
                      //available_qty
                      FormBuilderTextField(
                        name: 'available_qty',
                        initialValue: product.availableQty != null
                            ? product.availableQty.toString()
                            : "",
                        decoration: InputDecoration(
                          labelText: 'Available Qty'.i18n,
                        ),
                        onChanged: (value) {},
                        validator: FormBuilderValidators.compose([
                          // FormBuilderValidators.required(context),
                          // FormBuilderValidators.numeric(context),
                        ]),
                        keyboardType: TextInputType.number,
                      ).expand(),
                    ],
                  ),
                  //
                  UiSpacer.verticalSpace(),
                  //deliverable
                  FormBuilderCheckbox(
                    initialValue: product.deliverable == 1,
                    name: 'deliverable',
                    onChanged: (value) {},
                    title: "Can be delivered".i18n.text.make(),
                  ),
                  //Active
                  FormBuilderCheckbox(
                    initialValue: product.isActive == 1,
                    name: 'is_active',
                    onChanged: (value) {},
                    title: "Active".i18n.text.make(),
                  ),
                  //

                  //categories
                  vm.busy(vm.categories)
                      ? BusyIndicator().centered()
                      : FormBuilderFilterChip(
                          name: 'category_ids',
                          initialValue: product.categories.map((category)=> category.id.toString()).toList(),
                          decoration: InputDecoration(
                            labelText: 'Category'.i18n,
                          ),
                          spacing: 5,
                          selectedColor: AppColor.primaryColor,
                          options: vm.categories
                              .map(
                                (category) => FormBuilderFieldOption(
                                  value: '${category.id}',
                                  child: Text('${category.name}'),
                                ),
                              )
                              .toList(),
                        ),
                  UiSpacer.verticalSpace(),
                  //subcategories
                  vm.busy(vm.subCategories)
                      ? BusyIndicator().centered()
                      : FormBuilderFilterChip(
                          name: 'sub_category_ids',
                          initialValue: product.subCategories.map((category)=> category.id.toString()).toList(),
                          decoration: InputDecoration(
                            labelText: 'Sub-Category'.i18n,
                          ),
                          spacing: 5,
                          selectedColor: AppColor.primaryColor,
                          options: vm.subCategories
                              .map(
                                (category) => FormBuilderFieldOption(
                                  value: '${category.id}',
                                  child: Text('${category.name}'),
                                ),
                              )
                              .toList(),
                        ),
                  UiSpacer.verticalSpace(),
                  //menus
                  vm.busy(vm.menus)
                      ? BusyIndicator().centered()
                      : FormBuilderFilterChip(
                          name: 'menu_ids',
                          initialValue: product.menus.map((menu)=> menu.id.toString()).toList(),
                          decoration: InputDecoration(
                            labelText: 'Menus'.i18n,
                          ),
                          spacing: 5,
                          selectedColor: AppColor.primaryColor,
                          options: vm.menus
                              .map(
                                (menu) => FormBuilderFieldOption(
                                  value: '${menu.id}',
                                  child: Text('${menu.name}'),
                                ),
                              )
                              .toList(),
                        ),
                  UiSpacer.verticalSpace(),
                  //
                  CustomButton(
                    title: "Save Product".i18n,
                    loading: vm.isBusy,
                    onPressed: vm.processUpdateProduct,
                  ).centered().py12(),
                ],
              ),
            )
                .p20()
                .scrollVertical()
                .pOnly(bottom: context.mq.viewInsets.bottom),
          ),
        );
      },
    );
  }
}
