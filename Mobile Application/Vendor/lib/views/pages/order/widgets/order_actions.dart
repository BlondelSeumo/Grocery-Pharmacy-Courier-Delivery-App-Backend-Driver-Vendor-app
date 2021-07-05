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
    this.onEditPressed,
    this.onCancelledPressed,
    this.onAssignPressed,
    Key key,
  }) : super(key: key);

  final bool canChatCustomer;
  final bool busy;
  final Order order;
  final Function onEditPressed;
  final Function onCancelledPressed;
  final Function onAssignPressed;

  @override
  Widget build(BuildContext context) {
    return canChatCustomer
        ? SafeArea(
            child: busy
                ? BusyIndicator().centered().wh(Vx.dp40, Vx.dp40)
                : VStack(
                    [
                      HStack(
                        [
                          //edit order
                          Expanded(
                            child: order.canEditStatus
                                ? CustomButton(
                                    title: "Edit".i18n,
                                    icon: FlutterIcons.edit_ant,
                                    onPressed: onEditPressed,
                                  )
                                : UiSpacer.emptySpace(),
                          ),
                          UiSpacer.horizontalSpace(),
                          //cancel order
                          Expanded(
                            child: order.canCancel
                                ? CustomButton(
                                    color: Colors.red,
                                    title: "Cancel".i18n,
                                    icon: FlutterIcons.close_ant,
                                    onPressed: onCancelledPressed,
                                  )
                                : UiSpacer.emptySpace(),
                          ),
                        ],
                      ),

                      //
                      order.canAssignDriver
                          ? UiSpacer.verticalSpace()
                          : UiSpacer.emptySpace(),
                      //assign driver
                      order.canAssignDriver
                          ? CustomButton(
                              title: "Assign Order".i18n,
                              icon: FlutterIcons.truck_delivery_mco,
                              onPressed: onAssignPressed,
                            )
                          : UiSpacer.emptySpace(),
                    ],
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
