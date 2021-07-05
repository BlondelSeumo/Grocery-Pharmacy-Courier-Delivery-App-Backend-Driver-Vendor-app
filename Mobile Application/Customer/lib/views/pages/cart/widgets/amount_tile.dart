import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class AmountTile extends StatelessWidget {
  const AmountTile(this.title, this.amount,{Key key}) : super(key: key);

  final String title;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        title.text.make().expand(),
        UiSpacer.horizontalSpace(),
        amount.text.semiBold.xl.make(),
      ],
    );
  }
}
