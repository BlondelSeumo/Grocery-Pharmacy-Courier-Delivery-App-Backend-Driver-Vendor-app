import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/favourites.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.list_item.dart';
import 'package:fuodz/widgets/states/error.state.dart';
import 'package:fuodz/widgets/states/product.empty.dart';
import 'package:stacked/stacked.dart';
import 'package:fuodz/translations/favourites.i18n.dart';
import 'package:velocity_x/velocity_x.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouritesViewModel>.reactive(
      viewModelBuilder: () => FavouritesViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: true,
          title: "Favourites".i18n,
          isLoading: vm.isBusy,
          body: VStack(
            [
              //
              "Note: Tap & Hold to remove favourite".text.make().p20(),

              //
              CustomListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                dataSet: vm.products,
                isLoading: vm.busy(vm.products),
                emptyWidget: EmptyProduct(),
                errorWidget: LoadingError(
                  onrefresh: vm.fetchProducts,
                ),
                itemBuilder: (context, index) {
                  //
                  final product = vm.products[index];
                  //
                  return HorizontalProductListItem(
                    product,
                    onPressed: vm.openProductDetails,
                    qtyUpdated: vm.addToCartDirectly,
                  ).onLongPress(
                    () => vm.removeFavourite(product),
                  );
                },
                separatorBuilder: (context, index) =>
                    UiSpacer.verticalSpace(space: 10),
              ).expand(),
            ],
          ),
        );
      },
    );
  }
}
