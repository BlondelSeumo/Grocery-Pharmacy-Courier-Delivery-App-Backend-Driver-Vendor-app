import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderEditStatusBottomSheet extends StatefulWidget {
  OrderEditStatusBottomSheet({Key key, this.onConfirm}) : super(key: key);

  final Function(String) onConfirm;
  @override
  _OrderEditStatusBottomSheetState createState() =>
      _OrderEditStatusBottomSheetState();
}

class _OrderEditStatusBottomSheetState
    extends State<OrderEditStatusBottomSheet> {
  //
  List<String> statues = [
    'pending',
    'preparing',
    'ready',
    'enroute',
    'failed',
    'cancelled',
    'delivered'
  ];
  String selectedStatus;

  //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VStack(
        [
          //
          "Change Order Status".i18n.text.semiBold.xl.make(),
          //
          ...statues.map((e) {
            //
            return HStack(
              [
                //
                Radio(
                  value: e,
                  groupValue: selectedStatus,
                  onChanged: _changeSelectedStatus,
                ),
            
                //
                e.i18n.allWordsCapitilize().text.lg.light.make(),
              ],
            ).onInkTap(() => _changeSelectedStatus(e)).wFull(context);
          }).toList(),

          //
          UiSpacer.verticalSpace(),
          //
          CustomButton(
            title: "Change".i18n,
            onPressed: () {
              widget.onConfirm(selectedStatus);
            },
          ),
        ],
      ).p20().scrollVertical().hTwoThird(context),
    );
  }

  void _changeSelectedStatus(value) {
    setState(() {
      selectedStatus = value;
    });
  }
}
