import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/view_models/vendor/best_selling_products.vm.dart';
import 'package:fuodz/widgets/custom_grid_view.dart';
import 'package:fuodz/widgets/list_items/grid_view_product.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/best_selling_products.i18n.dart';

class BestSellingProducts extends StatelessWidget {
  const BestSellingProducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BestSellingProductsViewModel>.reactive(
      viewModelBuilder: () => BestSellingProductsViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return VStack(
          [
            //
            "Best Selling".i18n.text.xl.semiBold.make().p12(),

            //categories list
            // CustomListView(
            //   scrollDirection: Axis.horizontal,
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   dataSet: model.products,
            //   isLoading: model.isBusy,
            //   itemBuilder: (context, index) {
            //     //
            //     return ProductListItem(
            //       product: model.products[index],
            //       onPressed: model.productSelected,
            //       qtyUpdated: model.addToCartDirectly,
            //     );
            //   },
            // ).h(
            //   Vx.dp64 * (AppStrings.enableGroceryMode ? 3.5 : 2.5),
            // ),
            CustomGridView(
              // scrollDirection: Axis.horizontal,
              noScrollPhysics: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              dataSet: model.products,
              isLoading: model.isBusy,
              crossAxisSpacing: 10,
              childAspectRatio: AppStrings.enableGroceryMode ? 0.85 : 1,
              itemBuilder: (context, index) {
                //
                return GridViewProductListItem(
                  product: model.products[index],
                  onPressed: model.productSelected,
                  qtyUpdated: model.addToCartDirectly,
                );
              },
            ),
          ],
        ).py12();
      },
    );
  }
}
