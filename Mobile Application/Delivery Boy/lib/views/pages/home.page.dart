import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/views/pages/order/assigned_orders.page.dart';
import 'package:fuodz/views/pages/profile/profile.page.dart';
import 'package:fuodz/view_models/home.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/home.i18n.dart';

import 'order/orders.page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  @override
  void initState() { 
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback(
      (_) => LocationService.prepareLocationListener(),
    );
  }


  //
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return Scaffold(
          body: PageView(
            controller: vm.pageViewController,
            onPageChanged: vm.onPageChanged,
            children: [
              AssignedOrdersPage(),
              OrdersPage(),
              ProfilePage(),
            ],
          ),
          floatingActionButton: vm.isBusy
              ? BusyIndicator()
              : FloatingActionButton.extended(
                  icon: Icon(
                    !AppService.driverIsOnline
                        ? FlutterIcons.location_off_mdi
                        : FlutterIcons.location_on_mdi,
                    color: Colors.white,
                  ),
                  label: (AppService.driverIsOnline ? "You are Online" : "You are Offline")
                      .i18n
                      .text
                      .white
                      .make(),
                  backgroundColor: AppColor.primaryColor,
                  onPressed: vm.toggleOnlineStatus,
                ),
          bottomNavigationBar: VxBox(
            child: SafeArea(
              child: GNav(
                gap: 8,
                activeColor: Colors.white,
                color: Theme.of(context).textTheme.bodyText1.color,
                iconSize: 20,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                duration: Duration(milliseconds: 250),
                tabBackgroundColor: Theme.of(context).accentColor,
                tabs: [
                  GButton(
                    icon: FlutterIcons.rss_fea,
                    text: 'Assigned'.i18n,
                  ),
                  GButton(
                    icon: FlutterIcons.inbox_ant,
                    text: 'Orders'.i18n,
                  ),
                  GButton(
                    icon: FlutterIcons.menu_fea,
                    text: 'More'.i18n,
                  ),
                ],
                selectedIndex: vm.currentIndex,
                onTabChange: vm.onTabChange,
              ),
            ),
          )
              .p16
              .shadow
              .color(Theme.of(context).bottomSheetTheme.backgroundColor)
              .make(),
        );
      },
    );
  }
}
