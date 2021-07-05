import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/views/pages/package_types/package_type_pricing.page.dart';
import 'package:fuodz/views/pages/product/products.page.dart';
import 'package:fuodz/views/pages/profile/profile.page.dart';
import 'package:fuodz/view_models/home.vm.dart';
import 'package:fuodz/views/pages/vendor/vendor_details.page.dart';
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
              OrdersPage(),
              //
              (model.currentVendor == null ||
                      !model.currentVendor.isPackageType)
                  ? ProductsPage()
                  : PackagePricingPage(),

              VendorDetailsPage(),
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
                    icon: FlutterIcons.inbox_ant,
                    text: 'Orders'.i18n,
                  ),
                  GButton(
                    icon: (model.currentVendor == null ||
                            !model.currentVendor.isPackageType)
                        ? FlutterIcons.archive_fea
                        : FlutterIcons.money_faw,
                    text: ((model.currentVendor == null ||
                                !model.currentVendor.isPackageType)
                            ? 'Products'
                            : 'Pricing')
                        .i18n,
                  ),
                  GButton(
                    icon: FlutterIcons.briefcase_fea,
                    text: 'Vendor'.i18n,
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
