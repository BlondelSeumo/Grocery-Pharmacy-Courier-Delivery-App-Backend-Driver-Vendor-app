import 'package:flutter/material.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/form_step_controller.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/parcel_vendor.list_item.dart';
import 'package:fuodz/widgets/states/vendor.empty.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorPackageTypeSelector extends StatelessWidget {
  const VendorPackageTypeSelector({this.vm, Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        "Select Courier Vendor".i18n.text.xl.medium.make().py20(),
        //package type
        CustomListView(
          isLoading: vm.busy(vm.vendors),
          dataSet: vm.vendors,
          emptyWidget: EmptyVendor(showDescription: false),
          itemBuilder: (context, index) {
            //
            final vendor = vm.vendors[index];
            return ParcelVendorListItem(
              vendor,
              selected: vm.selectedVendor == vendor,
              onPressed: () => vm.changeSelectedVendor(vendor),
            );
          },
        ).expand(),

        //
        FormStepController(
          onPreviousPressed: () => vm.nextForm(0),
          onNextPressed:
              vm.selectedVendor != null ? () => vm.nextForm(2) : null,
        ),
      ],
    );
  }
}
