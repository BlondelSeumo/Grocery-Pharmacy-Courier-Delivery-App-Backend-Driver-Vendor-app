import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    this.title,
    this.child,
    this.divider = true,
    this.topDivider = false,
    this.suffix,
    this.onPressed,
    Key key,
  }) : super(key: key);

  //
  final String title;
  final Widget child;
  final bool divider;
  final bool topDivider;
  final Widget suffix;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        topDivider
            ? Divider(
                height: 1,
                thickness: 2,
              )
            : SizedBox.shrink(),

        //
        HStack(
          [
            //
            (child ?? title.text.lg.light.make()).expand(),
            //
            suffix ??
                Icon(
                  FlutterIcons.right_ant,
                  size: 16,
                ),
          ],
        ).py12().px8(),

        //
        divider
            ? Divider(
                height: 1,
                thickness: 2,
              )
            : SizedBox.shrink(),
      ],
    ).onInkTap(onPressed);
  }
}
