import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/orders.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/order.list_item.dart';
import 'package:fuodz/widgets/states/error.state.dart';
import 'package:fuodz/widgets/states/order.empty.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order.i18n.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with AutomaticKeepAliveClientMixin<OrdersPage> {
  //
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ViewModelBuilder<OrdersViewModel>.reactive(
        viewModelBuilder: () => OrdersViewModel(context),
        onModelReady: (vm) => vm.initialise(),
        builder: (context, vm, child) {
          return BasePage(
            body: VStack(
              [
                //
                HStack(
                  [
                    "Orders".i18n.text.xl2.semiBold.make().expand(),
                    UiSpacer.horizontalSpace(),
                    //
                    DropdownButton<String>(
                      items: vm.statuses.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: e.toLowerCase().i18n.allWordsCapitilize().text.make(),
                        );
                      }).toList(),
                      value: vm.selectedStatus,
                      onChanged: vm.statusChanged,
                    ),
                  ],
                ).py20(),
                //
                CustomListView(
                  canRefresh: true,
                  canPullUp: true,
                  refreshController: vm.refreshController,
                  onRefresh: vm.fetchMyOrders,
                  onLoading: () => vm.fetchMyOrders(initialLoading: false),
                  isLoading: vm.isBusy,
                  dataSet: vm.orders,
                  hasError: vm.hasError,
                  errorWidget: LoadingError(
                    onrefresh: vm.fetchMyOrders,
                  ),
                  //
                  emptyWidget: EmptyOrder(),
                  itemBuilder: (context, index) {
                    //
                    final order = vm.orders[index];
                    return OrderListItem(
                      order: order,
                      orderPressed: () => vm.openOrderDetails(order),
                    );
                  },
                ).expand(),
              ],
            ).px20(),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
