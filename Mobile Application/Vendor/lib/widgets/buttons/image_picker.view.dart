import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/others.i18n.dart';

class ImagePickerView extends StatelessWidget {
  const ImagePickerView(this.image, this.onPickPressed, this.onRemovePressed,
      {Key key})
      : super(key: key);

  final File image;
  final Function onPickPressed;
  final Function onRemovePressed;
  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: image == null
          ? "Select Image".i18n.text.makeCentered()
          : VStack(
              [
                //
                Image.file(
                  image,
                ).wFull(context).h(Vx.dp64 * 3),

                //
                CustomButton(
                  title: "Remove".i18n,
                  color: Colors.red,
                  onPressed: onRemovePressed,
                ),
              ],
            ),
    )
        .p12
        .color(context.theme.backgroundColor)
        .shadowMd
        .border(color: context.theme.highlightColor)
        .roundedSM
        .make()
        .wFull(context)
        .onInkTap(onPickPressed);
  }
}
