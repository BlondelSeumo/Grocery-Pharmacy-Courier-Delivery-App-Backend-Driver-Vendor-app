import 'package:flutter/material.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor_category_products.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorCategoryProductsPage extends StatefulWidget {
  VendorCategoryProductsPage({this.category, Key key}) : super(key: key);

  final Category category;

  @override
  _VendorCategoryProductsPageState createState() =>
      _VendorCategoryProductsPageState();
}

class _VendorCategoryProductsPageState extends State<VendorCategoryProductsPage>
    with TickerProviderStateMixin {
  //
  TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(
      length: widget.category.subcategories.length,
      vsync: this,
    );
  }

  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorCategoryProductsViewModel>.reactive(
      viewModelBuilder: () =>
          VendorCategoryProductsViewModel(context, widget.category),
      builder: (context, model, child) {
        return BasePage(
          title: model.category.name,
          showAppBar: true,
          showLeadingAction: true,
          showCart: true,
          body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
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
                    controller: tabBarController,
                    tabs: model.category.subcategories.map(
                      (subcategory) {
                        return Tab(
                          text: subcategory.name,
                        );
                      },
                    ).toList(),
                  ),
                ),
              ];
            },
            body: Container(
              child: TabBarView(
                controller: tabBarController,
                children: model.category.subcategories.map(
                  (subcategory) {
                    //
                    return CustomListView(
                      noScrollPhysics: true,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      dataSet: subcategory.products,
                      itemBuilder: (context, index) {
                        //
                        final product = subcategory.products[index];
                        return HorizontalProductListItem(
                          product,
                          onPressed: model.productSelected,
                          qtyUpdated: model.addToCartDirectly,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return UiSpacer.verticalSpace(space: 5);
                      },
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
