import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/views/pages/profile/profile.page.dart';
import 'package:fuodz/views/pages/cart/cart.page.dart';
import 'package:fuodz/view_models/home.vm.dart';
import 'package:fuodz/views/pages/welcome/welcome.page.dart';
import 'package:fuodz/widgets/base.page.dart';
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          body: PageView(
            controller: model.pageViewController,
            onPageChanged: model.onPageChanged,
            children: [
              WelcomePage(),
              OrdersPage(),
              CartPage(),
              ProfilePage(),
            ],
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
                    icon: FlutterIcons.home_ant,
                    text: 'Home'.i18n,
                  ),
                  GButton(
                    icon: FlutterIcons.inbox_ant,
                    text: 'Orders'.i18n,
                  ),
                  GButton(
                    icon: FlutterIcons.shopping_cart_fea,
                    text: 'Cart'.i18n,
                    leading: Stack(
                      children: [
                        //
                        Icon(
                          FlutterIcons.shopping_cart_fea,
                          size: 22,
                          color: model.currentIndex == 2
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyText1.color,
                        ),

                        //
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: model.totalCartItems.text.xs.white
                              .make()
                              .p4()
                              .box
                              .color(AppColor.primaryColorDark)
                              .roundedFull
                              .make(),
                        ),
                      ],
                    ),
                  ),
                  GButton(
                    icon: FlutterIcons.menu_fea,
                    text: 'More'.i18n,
                  ),
                ],
                selectedIndex: model.currentIndex,
                onTabChange: model.onTabChange,
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
