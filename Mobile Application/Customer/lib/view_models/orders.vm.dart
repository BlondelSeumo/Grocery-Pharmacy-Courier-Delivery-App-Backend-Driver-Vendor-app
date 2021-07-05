import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/requests/order.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/view_models/payment.view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class OrdersViewModel extends PaymentViewModel {
  //
  OrdersViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  OrderRequest orderRequest = OrderRequest();
  List<Order> orders = [];
  //
  int queryPage = 1;
  RefreshController refreshController = RefreshController();
  StreamSubscription homePageChangeStream;

  void initialise() async {
    await fetchMyOrders();

    homePageChangeStream = AppService.homePageIndex.stream.listen(
      (index) {
        //
        fetchMyOrders();
      },
    );
  }

  //
  dispose() {
    super.dispose();
    homePageChangeStream.cancel();
  }

  //
  fetchMyOrders({bool initialLoading = true}) async {
    if (initialLoading) {
      setBusy(true);
      refreshController.refreshCompleted();
      queryPage = 1;
    } else {
      queryPage++;
    }

    try {
      final mOrders = await orderRequest.getOrders(page: queryPage);
      if (!initialLoading) {
        orders.addAll(mOrders);
        refreshController.loadComplete();
      } else {
        orders = mOrders;
      }
      clearErrors();
    } catch (error) {
      print("Order Error ==> $error");
      setError(error);
    }

    setBusy(false);
  }

  refreshDataSet() {
    initialise();
  }

  openOrderDetails(Order order) async {
    final result = await viewContext.navigator.pushNamed(
      AppRoutes.orderDetailsRoute,
      arguments: order,
    );

    //
    if (result != null && (result is Order || result is bool)) {
      fetchMyOrders();
    }
  }

  void openLogin() async {
    await viewContext.navigator.pushNamed(AppRoutes.loginRoute);
    notifyListeners();
    fetchMyOrders();
  }
}
