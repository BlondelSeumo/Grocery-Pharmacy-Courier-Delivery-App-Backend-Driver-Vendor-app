import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:velocity_x/velocity_x.dart';

class WelcomeListItem extends StatelessWidget {
  const WelcomeListItem({
    this.title,
    this.text,
    this.imagePath,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final String title;
  final String text;
  final String imagePath;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: HStack(
        [
          //
          VxCircle(
            radius: 56,
            backgroundColor: AppColor.accentColor.withOpacity(0.6),
            child: Image.asset(
              imagePath,
              width: Vx.dp40,
              height: Vx.dp40,
            ).p8(),
          ).p12(),
          //
          VStack(
            [
              title.text.xl.color(AppColor.primaryColor).semiBold.make(),
              text.text.sm.make(),
            ],
          ).expand(),
        ],
      ).p12(),
    )
        .box
        .roundedSM
        .border(
          color: AppColor.accentColor.withOpacity(0.6),
          width: 3,
        )
        .make()
        .pOnly(bottom: Vx.dp20);
  }
}
