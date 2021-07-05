import 'package:flutter/material.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/views/pages/order/widgets/order.bottomsheet.dart';
import 'package:fuodz/views/pages/order/widgets/order_address.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_details_driver_info.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_details_header.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_details_items.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_details_recipent_info.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_details_vendor_info.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_payment_info.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_status.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/cards/order_summary.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({this.order, Key key}) : super(key: key);

  //
  final Order order;

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage>
    with WidgetsBindingObserver {
  //
  OrderDetailsViewModel vm;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && vm != null) {
      vm.fetchOrderDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    vm = OrderDetailsViewModel(context, widget.order);

    //
    return ViewModelBuilder<OrderDetailsViewModel>.reactive(
      viewModelBuilder: () => vm,
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          title: "Order Details".i18n,
          showAppBar: true,
          showLeadingAction: true,
          isLoading: vm.isBusy,
          onBackPressed: () {
            context.pop(widget.order.status != vm.order.status);
          },
          body: vm.isBusy
              ? BusyIndicator().centered()
              : VStack(
                  [
                    //header
                    OrderDetailsHeaderView(vm),
                    //show package delivery addresses
                    OrderAddressesView(vm),

                    //
                    (!vm.order.isPackageDelivery &&
                            vm.order.deliveryAddress == null)
                        ? "Customer Order Pickup"
                            .i18n
                            .text
                            .xl
                            .semiBold
                            .make()
                            .pOnly(bottom: Vx.dp20)
                        : UiSpacer.emptySpace(),

                    //status
                    OrderStatusView(vm),

                    //Payment status
                    OrderPaymentInfoView(vm),

                    //vendor
                    OrderDetailsVendorInfoView(vm),

                    //driver
                    OrderDetailsDriverInfoView(vm),

                    //recipient
                    OrderDetailsRecipentInfoView(vm),

                    //note
                    "Note".i18n.text.gray500.medium.sm.make(),
                    "${vm.order.note}"
                        .text
                        .medium
                        .xl
                        .italic
                        .make()
                        .pOnly(bottom: Vx.dp20),

                    // either products/package details
                    OrderDetailsItemsView(vm),

                    //order summary
                    OrderSummary(
                      subTotal: vm.order.subTotal,
                      discount: vm.order.discount,
                      deliveryFee: vm.order.deliveryFee,
                      tax: vm.order.tax,
                      vendorTax: ((vm.order.tax / vm.order.total) * 100)
                          .toDoubleStringAsFixed(),
                      total: vm.order.total,
                    ).pOnly(top: Vx.dp20, bottom: Vx.dp56),
                  ],
                )
                  .p20()
                  .pOnly(bottom: context.percentHeight * 20)
                  .scrollVertical(),
          bottomSheet: OrderBottomSheet(vm),
        );
      },
    );
  }
}
