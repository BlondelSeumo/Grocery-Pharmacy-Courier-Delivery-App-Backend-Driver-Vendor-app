import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/search.vm.dart';
import 'package:fuodz/views/pages/search/widget/search.header.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.list_item.dart';
import 'package:fuodz/widgets/list_items/vendor.list_item.dart';
import 'package:fuodz/widgets/states/search.empty.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/search.i18n.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key, this.search}) : super(key: key);

  //
  final Search search;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(context, search),
      builder: (context, model, child) {
        return BasePage(
          body: SafeArea(
            bottom: false,
            child: VStack(
              [
                //header
                SearchHeader(model),

                //Busy loading
                model.isBusy
                    ? BusyIndicator().centered()
                    : UiSpacer.emptySpace(),
                //tags
                HStack(
                  [
                    //
                    "Products"
                        .i18n
                        .text
                        .color(model.filterByProducts
                            ? Colors.white
                            : context.textTheme.bodyText1.color)
                        .make()
                        .py4()
                        .px12()
                        .box
                        .roundedLg
                        // .border(color: Colors.grey)
                        .border(
                            color: model.filterByProducts
                                ? Colors.white
                                : Colors.grey)
                        .color(model.filterByProducts
                            ? AppColor.primaryColor
                            : context.cardColor)
                        .makeCentered()
                        .pOnly(
                          right: AppService.isDirectionRTL(context)
                              ? Vx.dp0
                              : Vx.dp12,
                          left: AppService.isDirectionRTL(context)
                              ? Vx.dp12
                              : Vx.dp0,
                        )
                        .onInkTap(model.enableProductFilter),
                    "Vendors"
                        .i18n
                        .text
                        .color(!model.filterByProducts
                            ? Colors.white
                            : context.textTheme.bodyText1.color)
                        .make()
                        .py4()
                        .px12()
                        .box
                        .roundedLg
                        .border(
                            color: !model.filterByProducts
                                ? Colors.white
                                : Colors.grey)
                        .color(!model.filterByProducts
                            ? AppColor.primaryColor
                            : context.cardColor)
                        .makeCentered()
                        .onInkTap(model.enableVendorFilter),
                  ],
                ).py12(),

                VStack(
                  [
                    //products
                    CustomListView(
                      noScrollPhysics: true,
                      isLoading: model.isBusy,
                      dataSet: model.searchResults,
                      itemBuilder: (context, index) {
                        //
                        final searchResult = model.searchResults[index];
                        if (searchResult is Product) {
                          return HorizontalProductListItem(
                            searchResult,
                            onPressed: model.productSelected,
                            qtyUpdated: model.addToCartDirectly,
                          );
                        } else {
                          return VendorListItem(
                            vendor: searchResult,
                            onPressed: model.vendorSelected,
                          );
                        }
                      },
                      separatorBuilder: (context, index) =>
                          UiSpacer.verticalSpace(space: 5),
                      emptyWidget: EmptySearch(),
                    ),
                  ],
                )
                    .py12()
                    .scrollVertical(
                      controller: model.scrollController,
                    )
                    .expand(),
              ],
            ).pOnly(
              top: Vx.dp16,
              left: Vx.dp16,
              right: Vx.dp16,
            ),
          ),
        );
      },
    );
  }
}
