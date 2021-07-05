import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/view_models/products.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:fuodz/widgets/list_items/manage_product.list_item.dart';
import 'package:fuodz/widgets/states/error.state.dart';
import 'package:fuodz/widgets/states/product.empty.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/product.i18n.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with AutomaticKeepAliveClientMixin<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ViewModelBuilder<ProductViewModel>.reactive(
        viewModelBuilder: () => ProductViewModel(context),
        onModelReady: (vm) => vm.initialise(),
        builder: (context, vm, child) {
          return BasePage(
            fab: FloatingActionButton.extended(
              backgroundColor: AppColor.primaryColor,
              onPressed: vm.newProduct,
              label: "New Product".i18n.text.white.make(),
              icon: Icon(
                FlutterIcons.plus_fea,
                color: Colors.white,
              ),
            ),
            body: VStack(
              [
                //
                "Products".i18n.text.xl2.semiBold.make().pOnly(bottom: Vx.dp10),
                //search bar
                CustomTextFormField(
                  hintText: "Search".i18n,
                  onFieldSubmitted: vm.productSearch,
                ).pOnly(
                  top: Vx.dp4,
                  bottom: Vx.dp12,
                ),

                //
                CustomListView(
                  canRefresh: true,
                  canPullUp: true,
                  refreshController: vm.refreshController,
                  onRefresh: vm.fetchMyProducts,
                  onLoading: () => vm.fetchMyProducts(initialLoading: false),
                  isLoading: vm.isBusy,
                  dataSet: vm.products,
                  hasError: vm.hasError,
                  errorWidget: LoadingError(
                    onrefresh: vm.fetchMyProducts,
                  ),
                  //
                  emptyWidget: EmptyProduct(),
                  itemBuilder: (context, index) {
                    //
                    final product = vm.products[index];
                    return ManageProductListItem(
                      product,
                      isLoading: vm.busy(product.id),
                      onPressed: vm.openProductDetails,
                      onEditPressed: vm.editProduct,
                      onToggleStatusPressed: vm.changeProductStatus,
                      onDeletePressed: vm.deleteProduct,
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
