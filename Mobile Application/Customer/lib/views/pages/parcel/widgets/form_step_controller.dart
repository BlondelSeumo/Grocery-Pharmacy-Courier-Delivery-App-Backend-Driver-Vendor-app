import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';

class FormStepController extends StatelessWidget {
  const FormStepController({
    this.onPreviousPressed,
    this.onNextPressed,
    this.showPrevious = true,
    this.showNext = true,
    this.nextTitle,
    this.nextBtnWidth,
    Key key,
  }) : super(key: key);

  final Function onPreviousPressed;
  final bool showPrevious;
  final Function onNextPressed;
  final bool showNext;
  final String nextTitle;
  final double nextBtnWidth;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //prev
        showPrevious
            ? OutlinedButton(
                // height: Vx.dp40,
                child: "PREVIOUS".i18n.text.make(),
                onPressed: onPreviousPressed,
              ).py20().w(context.percentWidth * 35)
            : UiSpacer.emptySpace(),
        Spacer(),
        //next
        showNext
            ? CustomButton(
                height: Vx.dp40,
                title: nextTitle ?? "NEXT".i18n,
                onPressed: onNextPressed,
              ).py20().w(nextBtnWidth ?? (context.percentWidth * 35))
            : UiSpacer.emptySpace(),
      ],
    );
  }
}
