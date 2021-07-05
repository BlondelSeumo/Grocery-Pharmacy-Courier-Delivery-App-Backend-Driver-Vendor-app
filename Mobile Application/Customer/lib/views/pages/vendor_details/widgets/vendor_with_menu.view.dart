import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor_details.vm.dart';
import 'package:fuodz/views/pages/vendor_details/widgets/vendor_details_header.view.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorDetailsWithMenuPage extends StatefulWidget {
  VendorDetailsWithMenuPage({this.vendor, Key key}) : super(key: key);

  final Vendor vendor;

  @override
  _VendorDetailsWithMenuPageState createState() => _VendorDetailsWithMenuPageState();
}

class _VendorDetailsWithMenuPageState extends State<VendorDetailsWithMenuPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorDetailsViewModel>.reactive(
      viewModelBuilder: () =>
          VendorDetailsViewModel(context, widget.vendor, tickerProvider: this),
      onModelReady: (model) {
        model.tabBarController =
            TabController(length: model.vendor.menus.length ?? 0, vsync: this);
        model.getVendorDetails();
      },
      builder: (context, model, child) {
        return NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: VendorDetailsHeader(model),
              ),
              SliverAppBar(
                backgroundColor: context.theme.primaryColor,
                title: "".text.make(),
                floating: true,
                pinned: true,
                snap: true,
                primary: false,
                automaticallyImplyLeading: false,
                flexibleSpace: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  indicatorWeight: 2,
                  controller: model.tabBarController,
                  tabs: model.vendor.menus.map(
                    (menu) {
                      return Tab(
                        text: menu.name,
                      );
                    },
                  ).toList(),
                ),
              ),
            ];
          },
          body: Container(
            child: model.isBusy
                ? BusyIndicator().p20().centered()
                : TabBarView(
                    controller: model.tabBarController,
                    children: model.vendor.menus.map(
                      (menu) {
                        //
                        return CustomListView(
                          noScrollPhysics: true,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          dataSet: menu.products,
                          itemBuilder: (context, index) {
                            //
                            final product = menu.products[index];
                            return HorizontalProductListItem(
                              product,
                              onPressed: model.productSelected,
                              qtyUpdated: model.addToCartDirectly,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              UiSpacer.verticalSpace(space: 5),
                        );
                      },
                    ).toList(),
                  ),
          ),
        );
      },
    );
  }
}
