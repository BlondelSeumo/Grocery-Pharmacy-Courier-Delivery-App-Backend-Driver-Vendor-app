import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: "".text.make(),
    )
        .height(context.percentHeight * 10)
        .width(context.percentWidth * 100)
        .roundedFull
        .clip(Clip.antiAlias)
        .make()
        .backgroundColor(
          Colors.grey[900],
        )
        .shimmer(
          primaryColor: context.theme.backgroundColor,
          secondaryColor: context.theme.highlightColor,
        );
  }
}
