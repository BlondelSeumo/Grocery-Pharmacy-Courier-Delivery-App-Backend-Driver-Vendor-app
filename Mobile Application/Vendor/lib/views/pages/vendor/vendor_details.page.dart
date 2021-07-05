import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor_details.view_model.dart';
import 'package:fuodz/views/pages/vendor/widgets/vendor_sales.chart.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor.i18n.dart';
import 'package:numeral/numeral.dart';

class VendorDetailsPage extends StatefulWidget {
  const VendorDetailsPage({Key key}) : super(key: key);

  @override
  _VendorDetailsPageState createState() => _VendorDetailsPageState();
}

class _VendorDetailsPageState extends State<VendorDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorDetailsViewModel>.reactive(
      viewModelBuilder: () => VendorDetailsViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          body: SafeArea(
            child: VStack(
              [
                //
                "Vendor Details"
                    .i18n
                    .text
                    .xl2
                    .semiBold
                    .make().px20()
                    .pOnly(bottom: Vx.dp10),

                //
                SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: vm.refreshController,
                  onRefresh: () => vm.fetchVendorDetails(refresh: true),
                  child: vm.isBusy
                      ? BusyIndicator().centered()
                      : VStack(
                          [
                            // transactions/orders stats
                            VendorSalesChart(vm: vm),
                            //total orders
                            HStack(
                              [
                                //
                                "Total Orders"
                                    .i18n
                                    .text
                                    .lg
                                    .white
                                    .make()
                                    .expand(),
                                UiSpacer.horizontalSpace(),
                                "${Numeral(vm.totalOrders).value()}"
                                    .text
                                    .xl
                                    .semiBold
                                    .white
                                    .make(),
                              ],
                            )
                                .p20()
                                .box
                                .rounded
                                .shadow
                                .color(AppColor.accentColor.withOpacity(0.8))
                                .make()
                                .py16(),

                            ////earnings

                            HStack(
                              [
                                //
                                "Total Earnings \n(Currently)"
                                    .i18n
                                    .text
                                    .lg
                                    .white
                                    .make()
                                    .expand(),
                                UiSpacer.horizontalSpace(),
                                "${vm.currencySymbol} ${Numeral(vm.totalEarning).value()}"
                                    .text
                                    .xl
                                    .semiBold
                                    .white
                                    .make(),
                              ],
                            )
                                .p20()
                                .box
                                .rounded
                                .outerShadow
                                .color(AppColor.accentColor)
                                .make(),

                            //vendor details
                            VStack(
                              [
                                //name
                                "Name".i18n.text.lg.make(),
                                "${vm.vendor?.name ?? ''}"
                                    .text
                                    .xl
                                    .semiBold
                                    .make()
                                    .pOnly(bottom: Vx.dp12),
                                // address
                                "Address".i18n.text.lg.make(),
                                "${vm.vendor?.address ?? ''}"
                                    .text
                                    .xl
                                    .semiBold
                                    .make()
                                    .pOnly(bottom: Vx.dp12),
                              ],
                            )
                                .p20()
                                .box
                                .rounded
                                .color(context.cardColor)
                                .outerShadow
                                .make()
                                .wFull(context)
                                .pOnly(top: Vx.dp12, bottom: Vx.dp32),
                          ],
                        ).px20().scrollVertical(),
                ).expand(),
              ],
            ),
          ),
        );
      },
    );
  }

  //
  //
}
