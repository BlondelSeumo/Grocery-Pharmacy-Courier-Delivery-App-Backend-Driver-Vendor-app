import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/translations/order_details.i18n.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderActions extends StatelessWidget {
  const OrderActions({
    this.canChatCustomer,
    this.busy,
    this.order,
    this.processOrderCompletion,
    this.processOrderEnroute,
    Key key,
  }) : super(key: key);

  final bool canChatCustomer;
  final bool busy;
  final Order order;
  final Function processOrderCompletion;
  final Function processOrderEnroute;

  @override
  Widget build(BuildContext context) {
    return canChatCustomer
        ? SafeArea(
            child: busy
                ? BusyIndicator().centered().wh(Vx.dp40, Vx.dp40)
                : order.status != "enroute"
                    ? CustomButton(
                        onLongPress: processOrderEnroute,
                        title: "Long Press To Start".i18n,
                        icon: FlutterIcons.arrow_down_thick_mco,
                      )
                    : CustomButton(
                        onLongPress: processOrderCompletion,
                        title: "Long Press To Complete".i18n,
                        icon: FlutterIcons.arrow_down_thick_mco,
                      ),
          )
            .box
            .p20
            .outerShadow2Xl
            .shadow
            .color(context.cardColor)
            .make()
            .wFull(context)
        : UiSpacer.emptySpace();
  }
}
