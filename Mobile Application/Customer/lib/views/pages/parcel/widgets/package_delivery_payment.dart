import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/cart/widgets/amount_tile.dart';
import 'package:fuodz/views/pages/parcel/widgets/form_step_controller.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_grid_view.dart';
import 'package:fuodz/widgets/list_items/payment_method.list_item.dart';
import 'package:velocity_x/velocity_x.dart';

class PackageDeliveryPayment extends StatelessWidget {
  const PackageDeliveryPayment({this.vm, Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //info
        VStack(
          [
            UiSpacer.formVerticalSpace(),
            "Payment".i18n.text.xl2.semiBold.make().py12(),
            //payment details summary
            vm.busy(vm.packageCheckout)
                ? BusyIndicator().centered()
                : vm.hasErrorForKey(vm.packageCheckout)
                    ? "${vm.error(vm.packageCheckout)}".i18n
                        .text
                        .red500
                        .makeCentered()
                        .box
                        .p12
                        .roundedSM
                        .border(color: Colors.grey[400])
                        .make()
                        .wFull(context)
                    : VStack(
                        [
                          AmountTile(
                            "Distance".i18n,
                            vm.packageCheckout.distance.numCurrency + " km",
                          ),
                          AmountTile(
                            "Delivery Charges".i18n,
                            vm.currencySymbol +
                                " " +
                                vm.packageCheckout.deliveryFee.numCurrency,
                          ),
                          AmountTile(
                            "Package Size Charges".i18n,
                            vm.currencySymbol +
                                " " +
                                vm.packageCheckout.packageTypeFee.numCurrency,
                          ),
                          DottedLine().py12(),
                          AmountTile(
                            "Subtotal".i18n,
                            vm.currencySymbol +
                                    " " +
                                    vm.packageCheckout.subTotal.numCurrency ??
                                "",
                          ),
                          AmountTile(
                            "Tax".i18n,
                            vm.currencySymbol +
                                    " " +
                                    vm.packageCheckout.tax.numCurrency ??
                                "",
                          ),
                          DottedLine().py12(),
                          AmountTile(
                            "Total".i18n,
                            vm.currencySymbol +
                                    " " +
                                    vm.packageCheckout.total.numCurrency ??
                                "",
                          ),
                        ],
                      ),
            //
            UiSpacer.formVerticalSpace(),
            Divider(),
            UiSpacer.formVerticalSpace(),
            "Payment Methods".i18n.text.semiBold.xl.make(),
            "Please select your mode of payment".i18n.text.lg.make(),
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
                  selected: paymentMethod == vm.selectedPaymentMethod,
                  onSelected: vm.changeSelectedPaymentMethod,
                );
              },
            ).pOnly(top: Vx.dp16),
          ],
        ).scrollVertical().expand(),

        //
        FormStepController(
          onPreviousPressed: () => vm.nextForm(5),
          nextTitle: "PLACE ORDER".i18n,
          nextBtnWidth: context.percentWidth * 45,
          onNextPressed: vm.selectedPaymentMethod != null &&
                  !vm.hasErrorForKey(vm.packageCheckout)
              ? vm.initiateOrderPayment
              : null,
        ),
      ],
    );
  }
}
