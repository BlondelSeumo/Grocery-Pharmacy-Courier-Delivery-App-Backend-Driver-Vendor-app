import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/cart.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/cart.i18n.dart';

class ApplyCoupon extends StatelessWidget {
  const ApplyCoupon(this.vm, {Key key}) : super(key: key);

  final CartViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        "Add Coupon".i18n.text.semiBold.xl.make(),
        UiSpacer.verticalSpace(space: 10),
        //
        HStack(
          [
            //
            CustomTextFormField(
              hintText: "Coupon Code".i18n,
              textEditingController: vm.couponTEC,
              errorText:
                  vm.hasErrorForKey(vm.coupon) ? vm.error(vm.coupon).toString() : null,
              onChanged: vm.couponCodeChange,
            ).expand(flex: 2),
            //
            UiSpacer.horizontalSpace(),
            CustomButton(
              title: "Apply".i18n,
              isFixedHeight: true,
              loading: vm.busy(vm.coupon),
              onPressed: vm.canApplyCoupon ? vm.applyCoupon : null,
            ).h(Vx.dp56).expand(),
          ],
        ),
      ],
    );
  }
}
