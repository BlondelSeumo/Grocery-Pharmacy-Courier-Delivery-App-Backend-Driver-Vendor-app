import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/checkout.vm.dart';
import 'package:fuodz/views/pages/checkout/widgets/order_delivery_address.view.dart';
import 'package:fuodz/views/pages/checkout/widgets/schedule_order.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/translations/checkout.i18n.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/cards/order_summary.dart';
import 'package:fuodz/widgets/custom_grid_view.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:fuodz/widgets/list_items/payment_method.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:supercharged/supercharged.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({this.checkout, Key key}) : super(key: key);

  final CheckOut checkout;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutViewModel>.reactive(
      viewModelBuilder: () => CheckoutViewModel(context, checkout),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: true,
          title: "Checkout".i18n,
          body: VStack(
            [
              //
              UiSpacer.verticalSpace(),
              CustomTextFormField(
                labelText: "Driver Tip".i18n+" (${AppStrings.currencySymbol})",
                textEditingController: vm.driverTipTEC,
                keyboardType: TextInputType.number,
                onChanged: (value) => vm.updateCheckoutTotalAmount(),
              ).pOnly(bottom: Vx.dp20),
              //
              CustomTextFormField(
                labelText: "Note".i18n,
                textEditingController: vm.noteTEC,
              ),

              //note
              Divider(thickness: 3).py12(),

              //pickup time slot
              ScheduleOrderView(vm),

              //its pickup
              OrderDeliveryAddressPickerView(vm),

              //payment options
              Visibility(
                visible: vm.canSelectPaymentOption,
                child: VStack(
                  [
                    "Payment Methods".i18n.text.semiBold.xl.make(),
                    CustomGridView(
                      noScrollPhysics: true,
                      dataSet: vm.paymentMethods,
                      childAspectRatio: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemBuilder: (context, index) {
                        //
                        final paymentMethod = vm.paymentMethods[index];
                        return PaymentOptionListItem(
                          paymentMethod,
                          selected: vm.isSelected(paymentMethod),
                          onSelected: vm.changeSelectedPaymentMethod,
                        );
                      },
                    ).pOnly(top: Vx.dp16),
                    //
                    Divider(thickness: 3).py12(),
                  ],
                ),
              ),

              //order final price preview
              OrderSummary(
                subTotal: vm.checkout.subTotal,
                discount: vm.checkout.discount,
                deliveryFee: vm.checkout.deliveryFee,
                tax: vm.checkout.tax,
                vendorTax: vm.vendor.tax,
                driverTip: vm.driverTipTEC.text.toDouble() ?? 0.00,
                total: vm.checkout.totalWithTip,
              ),

              //
              CustomButton(
                title: "PLACE ORDER".i18n.padRight(14),
                icon: FlutterIcons.credit_card_fea,
                onPressed: vm.placeOrder,
                loading: vm.isBusy,
              ).centered().py16(),
            ],
          ).p20().scrollVertical().pOnly(bottom: context.mq.viewInsets.bottom),
        );
      },
    );
  }
}
