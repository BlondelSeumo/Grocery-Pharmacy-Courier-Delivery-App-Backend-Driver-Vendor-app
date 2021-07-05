import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/empty.i18n.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key key,
    this.imageUrl,
    this.title = "",
    this.actionText = "Action",
    this.description = "",
    this.showAction = false,
    this.actionPressed,
    this.auth = false,
  }) : super(key: key);

  final String title;
  final String actionText;
  final String description;
  final String imageUrl;
  final Function actionPressed;
  final bool showAction;
  final bool auth;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        (imageUrl != null && imageUrl.isNotBlank)
            ? Image.asset(imageUrl)
                .wh(
                  Vx.dp64 * 2,
                  Vx.dp64 * 2,
                )
                .box
                .makeCentered()
                .wFull(context)
            : UiSpacer.emptySpace(),

        //
        (title != null && title.isNotEmpty)
            ? title.text.xl.semiBold.center.makeCentered()
            : SizedBox.shrink(),

        //
        auth
            ? Image.asset(AppImages.auth)
                .wh(
                  Vx.dp64,
                  Vx.dp64,
                )
                .box
                .makeCentered().py12()
                .wFull(context)
            : SizedBox.shrink(),
        //
        auth
            ? "You have to login to access profile and history"
                .i18n
                .text
                .center
                .lg
                .light
                .makeCentered().py12()
            : description.isNotEmpty
                ? description.text.lg.light.center.makeCentered()
                : SizedBox.shrink(),

        //
        auth
            ? CustomButton(
                title: "Login".i18n,
                onPressed: actionPressed,
              ).centered()
            : showAction
                ? CustomButton(
                    title: actionText,
                    onPressed: actionPressed,
                  ).centered().py12()
                : SizedBox.shrink(),
      ],
    );
  }
}
