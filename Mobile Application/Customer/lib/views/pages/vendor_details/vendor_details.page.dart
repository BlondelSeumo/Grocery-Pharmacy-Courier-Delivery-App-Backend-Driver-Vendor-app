import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/view_models/vendor_details.vm.dart';
import 'package:fuodz/views/pages/vendor_details/widgets/vendor_with_menu.view.dart';
import 'package:fuodz/views/pages/vendor_details/widgets/vendor_with_subcategory.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorDetailsPage extends StatelessWidget {
  VendorDetailsPage({this.vendor, Key key}) : super(key: key);

  final Vendor vendor;

  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorDetailsViewModel>.reactive(
      viewModelBuilder: () => VendorDetailsViewModel(context, vendor),
      onModelReady: (model) => model.getVendorDetails(),
      builder: (context, model, child) {
        return BasePage(
          title: model.vendor.name,
          showAppBar: true,
          showLeadingAction: true,
          showCart: !model.vendor.hasSubcategories,
          body: VStack(
            [
              //
              Visibility(
                visible: !model.vendor.hasSubcategories,
                child: VendorDetailsWithMenuPage(vendor: model.vendor).expand(),
              ),

              //subcategories
              Visibility(
                visible: model.vendor.hasSubcategories,
                child: VendorDetailsWithSubcategoryPage(vendor: model.vendor).expand(),
              ),
            ],
          ),
        );
      },
    );
  }
}
