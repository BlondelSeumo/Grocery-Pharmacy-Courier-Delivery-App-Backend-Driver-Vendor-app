import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/form_step_controller.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/package_type.list_item.dart';
import 'package:velocity_x/velocity_x.dart';

class PackageTypeSelector extends StatelessWidget {
  const PackageTypeSelector({this.vm, Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        "Select Package Type".i18n.text.xl.medium.make().py20(),
        //package type
        CustomListView(
          isLoading: vm.busy(vm.packageTypes),
          dataSet: vm.packageTypes,
          itemBuilder: (context, index) {
            //
            final packageType = vm.packageTypes[index];
            return PackageTypeListItem(
              packageType: packageType,
              selected: vm.selectedPackgeType == packageType,
              onPressed: () => vm.changeSelectedPackageType(packageType),
            );
          },
        ).expand(),

        //
        FormStepController(
          showPrevious: false,
          onNextPressed: vm.selectedPackgeType != null
              ? () => vm.nextForm(
                    AppStrings.enableSingleVendor ? 2 : 1,
                  )
              : null,
        ),
      ],
    );
  }
}
