import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/welcome.vm.dart';
import 'package:fuodz/widgets/list_items/welcome.list_item.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/welcome.i18n.dart';

class EmptyWelcome extends StatelessWidget {
  const EmptyWelcome({this.vm, Key key}) : super(key: key);

  final WelcomeViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        VxBox(
          child: SafeArea(
            child: VStack(
              [
                "Welcome".i18n.text.white.xl3.semiBold.make(),
                "How can I help you today?".i18n.text.white.xl.medium.make(),
              ],
            ).py12(),
          ),
        ).color(AppColor.primaryColor).p20.make().wFull(context),
        //
        VStack(
          [
            "I want to:".i18n.text.xl.medium.make().py12(),
            //
            AppStrings.enableParcel
                ? WelcomeListItem(
                    title: "Send packages".i18n,
                    text: "Send packages to anyone, anywhere at anytime".i18n,
                    imagePath: AppImages.deliveryParcel,
                    onPressed: () => vm.pageSelected(1, "Send Package".i18n),
                  )
                : UiSpacer.emptySpace(),
            //
            AppStrings.enableFood
                ? WelcomeListItem(
                    title: "Get Food/Grocery Delivery".i18n,
                    text: "Order for food, grocery and more from nearby vendors"
                        .i18n,
                    imagePath: AppImages.deliveryVendor,
                    onPressed: () => vm.pageSelected(2, "Market".i18n),
                  )
                : UiSpacer.emptySpace(),
          ],
        ).p20(),
      ],
    ).scrollVertical();
  }
}
