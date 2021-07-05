import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class DeliveryAddressListItem extends StatelessWidget {
  const DeliveryAddressListItem({
    this.deliveryAddress,
    this.onEditPressed,
    this.onDeletePressed,
    this.action = true,
    this.border = true,
    this.showDefault = true,
    Key key,
  }) : super(key: key);

  final DeliveryAddress deliveryAddress;
  final Function onEditPressed;
  final Function onDeletePressed;
  final bool action;
  final bool border;
  final bool showDefault;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        VStack(
          [
            deliveryAddress.name.text.semiBold.lg.make(),
            deliveryAddress.address.text.sm
                .maxLines(3)
                .overflow(TextOverflow.ellipsis)
                .make(),
            (deliveryAddress.defaultDeliveryAddress && showDefault)
                ? "Default"
                    .text
                    .xs
                    .italic
                    .maxLines(3)
                    .overflow(TextOverflow.ellipsis)
                    .make()
                : UiSpacer.emptySpace(),
          ],
        ).p12().expand(),
        //
        this.action
            ? VStack(
                [
                  //delete icon
                  Icon(
                    FlutterIcons.delete_ant,
                    size: 16,
                    color: Colors.white,
                  )
                      .wFull(context)
                      .onInkTap(this.onDeletePressed)
                      .py12()
                      .box
                      .red500
                      .make(),
                  //edit icon
                  Icon(
                    FlutterIcons.edit_ent,
                    size: 16,
                    color: Colors.white,
                  )
                      .wFull(context)
                      .onInkTap(this.onEditPressed)
                      .py12()
                      .box
                      .blue500
                      .make(),
                ],
                axisSize: MainAxisSize.max,
                // crossAlignment: CrossAxisAlignment.center,
              ).w(context.percentWidth * 15)
            : UiSpacer.emptySpace(),
      ],
    )
        .box
        .roundedSM
        .clip(Clip.antiAlias)
        .border(
          color: border ? context.accentColor : Colors.transparent,
          width: border ? 2 : 0,
        )
        .make();
  }
}
