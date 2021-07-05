import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/views/pages/order/widgets/order_actions.dart';
import 'package:fuodz/views/pages/order/widgets/order_address.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_payment_info.view.dart';
import 'package:fuodz/views/pages/order/widgets/recipient_info.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/cards/amount_tile.dart';
import 'package:fuodz/widgets/cards/order_summary.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/order_product.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({this.order, Key key}) : super(key: key);

  //
  final Order order;

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: ViewModelBuilder<OrderDetailsViewModel>.reactive(
        viewModelBuilder: () => OrderDetailsViewModel(context, order),
        onModelReady: (vm) => vm.initialise(),
        builder: (context, vm, child) {
          return BasePage(
            title: "Order Details".i18n,
            showAppBar: true,
            showLeadingAction: true,
            onBackPressed: vm.onBackPressed,
            isLoading: vm.isBusy,
            body: vm.isBusy
                ?  BusyIndicator().centered()
                : VStack(
                    [
                      //code & total amount
                      HStack(
                        [
                          //
                          VStack(
                            [
                              "Code".i18n.text.gray500.medium.sm.make(),
                              "#${vm.order.code}".text.medium.xl.make(),
                            ],
                          ).expand(),
                          //total amount
                          AppStrings.currencySymbol.text.medium.lg.make().px4(),
                          (vm.order.total ?? 0.00)
                              .numCurrency
                              .text
                              .medium
                              .xl2
                              .make(),
                        ],
                      ).pOnly(bottom: Vx.dp20),

                      //order delivery/pickup location
                      OrderAddressView(vm),

                      //status
                      "Status".i18n.text.gray500.medium.sm.make(),
                      vm.order.status
                          .allWordsCapitilize()
                          .text
                          .color(AppColor.getStausColor(vm.order.status))
                          .medium
                          .xl
                          .make()
                          .pOnly(bottom: Vx.dp20),

                      //payment status 
                      OrderPaymentInfoView(vm),

                      //vendor
                      HStack(
                        [
                          //
                          VStack(
                            [
                              "Vendor".i18n.text.gray500.medium.sm.make(),
                              vm.order.vendor.name
                                  .allWordsCapitilize()
                                  .text
                                  .medium
                                  .xl
                                  .make()
                                  .pOnly(bottom: Vx.dp20),
                            ],
                          ).expand(),
                          //call
                          CustomButton(
                            icon: FlutterIcons.phone_call_fea,
                            iconColor: Colors.white,
                            color: AppColor.primaryColor,
                            shapeRadius: Vx.dp20,
                            onPressed: vm.callVendor,
                          ).wh(Vx.dp64, Vx.dp40).p12(),
                        ],
                      ),

                      //vendor routing
                      HStack(
                        [
                          VStack(
                            [
                              "Vendor Address".i18n.text.gray500.medium.sm.make(),
                              vm.order.vendor.address.text
                                  .make()
                                  .pOnly(bottom: Vx.dp20),
                            ],
                          ).expand(),
                          //route
                          CustomButton(
                            icon: FlutterIcons.navigation_fea,
                            iconColor: Colors.white,
                            color: AppColor.primaryColor,
                            shapeRadius: Vx.dp20,
                            onPressed: () => vm.routeToLocation(
                              DeliveryAddress(
                                  name: vm.order.vendor.name,
                                  latitude:
                                      double.parse(vm.order.vendor.latitude),
                                  longitude:
                                      double.parse(vm.order.vendor.longitude)),
                            ),
                          ).wh(Vx.dp64, Vx.dp40).p12(),
                        ],
                      ),

                      //chat
                      vm.order.canChatVendor
                          ? CustomButton(
                              icon: FlutterIcons.chat_ent,
                              iconColor: Colors.white,
                              title: "Chat with vendor".i18n,
                              color: AppColor.primaryColor,
                              onPressed: vm.chatVendor,
                            ).h(Vx.dp48).pOnly(top: Vx.dp12, bottom: Vx.dp20)
                          : UiSpacer.emptySpace(),

                      //customer
                      HStack(
                        [
                          //
                          VStack(
                            [
                              "Customer".i18n.text.gray500.medium.sm.make(),
                              vm.order.user.name
                                  .allWordsCapitilize()
                                  .text
                                  .medium
                                  .xl
                                  .make()
                                  .pOnly(bottom: Vx.dp20),
                            ],
                          ).expand(),
                          //call
                          vm.order.canChatCustomer
                              ? CustomButton(
                                  icon: FlutterIcons.phone_call_fea,
                                  iconColor: Colors.white,
                                  color: AppColor.primaryColor,
                                  shapeRadius: Vx.dp20,
                                  onPressed: vm.callCustomer,
                                ).wh(Vx.dp64, Vx.dp40).p12()
                              : UiSpacer.emptySpace(),
                        ],
                      ),
                      vm.order.canChatCustomer
                          ? CustomButton(
                              icon: FlutterIcons.chat_ent,
                              iconColor: Colors.white,
                              title: "Chat with customer".i18n,
                              color: AppColor.primaryColor,
                              onPressed: vm.chatCustomer,
                            ).h(Vx.dp48).pOnly(top: Vx.dp12, bottom: Vx.dp20)
                          : UiSpacer.emptySpace(),

                      //recipient
                      RecipientInfo(
                        callRecipient: vm.callRecipient,
                        order: vm.order,
                      ),

                      //note
                      "Note".i18n.text.gray500.medium.sm.make(),
                      (vm.order.note ?? "--")
                          .text
                          .medium
                          .xl
                          .italic
                          .make()
                          .pOnly(bottom: Vx.dp20),

                      // either products/package details
                      (vm.order.isPackageDelivery
                              ? "Package Details"
                              : "Products")
                          .i18n
                          .text
                          .gray500
                          .semiBold
                          .xl
                          .make()
                          .pOnly(bottom: Vx.dp10),
                      vm.order.isPackageDelivery
                          ? VStack(
                              [
                                AmountTile(
                                  "Package Type".i18n,
                                  vm.order.packageType.name,
                                ),
                                AmountTile("Width".i18n, vm.order.width + "cm"),
                                AmountTile("Length".i18n, vm.order.length + "cm"),
                                AmountTile("Height".i18n, vm.order.height + "cm"),
                                AmountTile("Weight".i18n, vm.order.weight + "kg"),
                              ],
                              crossAlignment: CrossAxisAlignment.end,
                            )
                          : CustomListView(
                              noScrollPhysics: true,
                              dataSet: vm.order.orderProducts,
                              itemBuilder: (context, index) {
                                //
                                final orderProduct =
                                    vm.order.orderProducts[index];
                                return OrderProductListItem(
                                  orderProduct: orderProduct,
                                );
                              },
                            ),

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
                    .pOnly(bottom: context.percentHeight * 30)
                    .scrollVertical(),

            //
            bottomSheet: OrderActions(
              order: vm.order,
              canChatCustomer: vm.order.canChatCustomer,
              busy: vm.isBusy || vm.busy(vm.order),
              processOrderCompletion: vm.initiateOrderCompletion,
              processOrderEnroute: vm.processOrderEnroute,
            ),
          );
        },
      ),
    );
  }
}
