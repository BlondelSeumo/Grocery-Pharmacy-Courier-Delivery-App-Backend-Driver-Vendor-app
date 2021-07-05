import 'package:flutter/material.dart';
import 'package:fuodz/view_models/assigned_orders.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/order.list_item.dart';
import 'package:fuodz/widgets/states/error.state.dart';
import 'package:fuodz/widgets/states/order.empty.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order.i18n.dart';

class AssignedOrdersPage extends StatefulWidget {
  const AssignedOrdersPage({Key key}) : super(key: key);

  @override
  _AssignedOrdersPageState createState() => _AssignedOrdersPageState();
}

class _AssignedOrdersPageState extends State<AssignedOrdersPage>
    with AutomaticKeepAliveClientMixin<AssignedOrdersPage> {


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ViewModelBuilder<AssignedOrdersViewModel>.reactive(
        viewModelBuilder: () => AssignedOrdersViewModel(),
        onModelReady: (vm) => vm.initialise(),
        builder: (context, vm, child) {
          return BasePage(
            body: VStack(
              [
                //
                "Assigned Orders"
                    .i18n
                    .text
                    .xl2
                    .semiBold
                    .make()
                    .pOnly(bottom: Vx.dp10),
                //
                CustomListView(
                  canRefresh: true,
                  canPullUp: true,
                  refreshController: vm.refreshController,
                  onRefresh: vm.fetchOrders,
                  onLoading: () => vm.fetchOrders(initialLoading: false),
                  isLoading: vm.isBusy,
                  dataSet: vm.orders,
                  hasError: vm.hasError,
                  errorWidget: LoadingError(
                    onrefresh: vm.fetchOrders,
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
