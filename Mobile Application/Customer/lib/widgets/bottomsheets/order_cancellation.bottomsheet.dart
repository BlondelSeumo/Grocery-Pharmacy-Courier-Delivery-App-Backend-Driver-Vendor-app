import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/translations/order_details.i18n.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderCancellationBottomSheet extends StatefulWidget {
  OrderCancellationBottomSheet({this.onSubmit, Key key}) : super(key: key);

  final Function(String) onSubmit;
  @override
  _OrderCancellationBottomSheetState createState() =>
      _OrderCancellationBottomSheetState();
}

class _OrderCancellationBottomSheetState
    extends State<OrderCancellationBottomSheet> {
  String _selectedReason = "custom";
  TextEditingController reasonTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        "Order Cancellation".i18n.text.semiBold.xl.make(),
        "Please state why you want to cancel order".i18n.text.make(),
        //default reasons
        RadioGroup<String>.builder(
          spacebetween: Vx.dp32,
          groupValue: _selectedReason,
          onChanged: (value) => setState(() {
            _selectedReason = value;
          }),
          items: AppStrings.orderCancellationReasons,
          itemBuilder: (item) => RadioButtonBuilder(
            item.i18n.allWordsCapitilize(),
          ),
        ).py12(),
        //custom
        _selectedReason == "custom"
            ? CustomTextFormField(
                labelText: "Reason".i18n,
                textEditingController: reasonTEC,
              ).py12()
            : UiSpacer.emptySpace(),
        //
        CustomButton(
          title: "Submit".i18n,
          onPressed: () {
            if (_selectedReason == "custom") {
              _selectedReason = reasonTEC.text;
            }
            //
            widget.onSubmit(_selectedReason);
          },
        ),
      ],
    ).p20().scrollVertical();
  }
}
