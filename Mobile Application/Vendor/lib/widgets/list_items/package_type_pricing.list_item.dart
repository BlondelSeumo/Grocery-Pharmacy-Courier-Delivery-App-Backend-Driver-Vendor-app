import 'package:flutter/material.dart';
import 'package:fuodz/models/package_type_pricing.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/pricing.i18n.dart';

class PackageTypePricingListItem extends StatelessWidget {
  //
  const PackageTypePricingListItem(this.packageTypePricing,
      {this.isLoading = false,
      this.onEditPressed,
      this.onToggleStatusPressed,
      this.onDeletePressed,
      Key key})
      : super(key: key);

  //
  final PackageTypePricing packageTypePricing;
  final bool isLoading;
  final Function(PackageTypePricing) onEditPressed;
  final Function(PackageTypePricing) onToggleStatusPressed;
  final Function(PackageTypePricing) onDeletePressed;
  @override
  Widget build(BuildContext context) {
    //
    final currencySymbol = AppStrings.currencySymbol;

    //
    return VStack(
      [
        HStack(
          [
            //
            CustomImage(imageUrl: packageTypePricing.packageType.photo)
                .wh(Vx.dp64, Vx.dp64)
                .box
                .clip(Clip.antiAlias)
                .roundedSM
                .make(),

            //Details
            //
            VStack(
              [
                //name
                packageTypePricing.packageType.name.text.xl.semiBold.make(),
                //name
                "${packageTypePricing.packageType.description}"
                    .text
                    .light
                    .maxLines(2)
                    .overflow(TextOverflow.ellipsis)
                    .make()
              ],
            ).expand(),
          ],
        ),

        //
        //Package & disctance price
        HStack(
          [
            //
            VStack(
              [
                //base price
                "Base Price".i18n.text.sm.medium.make(),
                //description
                "$currencySymbol ${packageTypePricing.basePrice.numCurrency}"
                    .text
                    .lg
                    .semiBold
                    .make(),
              ],
            ).expand(),

            //
            VStack(
              [
                //Package price
                "Package Price".i18n.text.sm.medium.make(),
                //description
                "$currencySymbol ${packageTypePricing.sizePrice.numCurrency}"
                    .text
                    .lg
                    .semiBold
                    .make(),
              ],
            ).expand(),
            //
            VStack(
              [
                //Distance price
                "Distance Price".i18n.text.sm.medium.make(),
                //description
                "$currencySymbol ${packageTypePricing.distancePrice.numCurrency}"
                    .text
                    .lg
                    .semiBold
                    .make(),
              ],
            ).expand(),
          ],
          crossAlignment: CrossAxisAlignment.start,
          alignment: MainAxisAlignment.spaceBetween,
        ).px20().py12(),

        //Auto ready & extra fileds
        HStack(
          [
            VStack(
              [
                //Package price
                "Auto Ready".i18n.text.sm.medium.make(),
                //description
                "${packageTypePricing.autoReady}"
                    .text
                    .color(packageTypePricing.autoReady
                        ? Colors.green
                        : Colors.red)
                    .lg
                    .semiBold
                    .make(),
              ],
            ).expand(),
            //
            VStack(
              [
                //Distance price
                "Extra fields".i18n.text.sm.medium.make(),
                "${packageTypePricing.extraFields}"
                    .text
                    .color(packageTypePricing.extraFields
                        ? Colors.green
                        : Colors.red)
                    .lg
                    .semiBold
                    .make(),
              ],
            ).expand(),

            ////Max booking days
            VStack(
              [
                //
                "Max booking days".i18n.text.sm.medium.make(),
                //description
                "${packageTypePricing.maxBookingDays}".text.lg.semiBold.make(),
              ],
            ).expand(),
          ],
          crossAlignment: CrossAxisAlignment.start,
          alignment: MainAxisAlignment.spaceBetween,
        ).px20().py12(),

        //actions
        HStack(
          [
            //
            CustomButton(
              loading: isLoading,
              height: 30,
              title: "Edit",
              onPressed: () => onEditPressed(packageTypePricing),
              color: Colors.grey,
            ).px12(),
            CustomButton(
              loading: isLoading,
              height: 30,
              title:
                  (packageTypePricing.isActive != 1 ? "Activate" : "Deactivate")
                      .i18n,
              onPressed: () => onToggleStatusPressed(packageTypePricing),
              color: packageTypePricing.isActive != 1
                  ? Colors.green
                  : Colors.red[400],
            ).px12(),
            CustomButton(
              loading: isLoading,
              height: 30,
              title: "Delete".i18n,
              onPressed: () => onDeletePressed(packageTypePricing),
              color: Colors.red,
            ).px12(),
          ],
          alignment: MainAxisAlignment.spaceEvenly,
          crossAlignment: CrossAxisAlignment.center,
        ),
        //
        UiSpacer.verticalSpace(),
      ],
    ).p8().box.outerShadow.color(context.cardColor).make();
  }
}
