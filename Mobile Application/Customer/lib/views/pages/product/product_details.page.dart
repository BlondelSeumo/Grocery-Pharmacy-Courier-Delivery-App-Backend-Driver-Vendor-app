import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/models/option_group.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/product_details.vm.dart';
import 'package:fuodz/views/pages/product/widgets/product_details.header.dart';
import 'package:fuodz/views/pages/product/widgets/product_details_cart.bottom_sheet.dart';
import 'package:fuodz/views/pages/product/widgets/product_option_group.dart';
import 'package:fuodz/views/pages/product/widgets/product_options.header.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/product_details.i18n.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({this.product, Key key}) : super(key: key);

  final Product product;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailsViewModel>.reactive(
      viewModelBuilder: () => ProductDetailsViewModel(context, product),
      onModelReady: (model) => model.getProductDetails(),
      builder: (context, model, child) {
        return BasePage(
          title: model.product.name,
          showAppBar: true,
          showLeadingAction: true,
          showCart: true,
          body: VStack(
            [
              //product image
              Hero(
                tag: model.product.heroTag,
                child: CustomImage(
                  imageUrl: model.product.photo,
                ).wFull(context).hOneThird(context),
              ),

              //product header
              ProductDetailsHeader(product: model.product),
              UiSpacer.divider().pOnly(bottom: Vx.dp12),

              //product details
              model.product.description.text.thin.sm.make().px20(),

              //options header
              ProductOptionsHeader(
                description: "Select options to add them to the product".i18n,
              ),

              //options
              model.busy(model.product)
                  ? BusyIndicator().centered().py20()
                  : VStack(
                      [
                        ...buildProductOptions(model),
                      ],
                    ),

              //more from vendor
              OutlinedButton.icon(
                onPressed: model.openVendorPage,
                icon: Icon(
                  FlutterIcons.business_center_mdi,
                ),
                label: Row(
                  children: [
                    ("View more from".i18n + "\n ${model.product.vendor.name}")
                        .text
                        .make().expand(),
                  ],
                ).py12().w56(context),
              ).centered().py16(),
            ],
          ).pOnly(bottom: context.percentHeight * 30).scrollVertical(),
          bottomSheet: ProductDetailsCartBottomSheet(model: model),
        );
      },
    );
  }

  //
  buildProductOptions(model) {
    return model.product.optionGroups.map((OptionGroup optionGroup) {
      return ProductOptionGroup(optionGroup: optionGroup, model: model);
    }).toList();
  }
}
