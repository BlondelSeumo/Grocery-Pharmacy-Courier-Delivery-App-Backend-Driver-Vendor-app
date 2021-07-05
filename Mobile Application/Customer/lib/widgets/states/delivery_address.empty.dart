import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/widgets/states/empty.state.dart';
import 'package:fuodz/translations/delivery_address/delivery_addresses.i18n.dart';

class EmptyDeliveryAddress extends StatelessWidget {
  const EmptyDeliveryAddress({
    Key key,
    this.selection = false,
  }) : super(key: key);

  final bool selection;
  @override
  Widget build(BuildContext context) {
    return EmptyState(
      imageUrl: AppImages.addressPin,
      title: selection
          ? "No Delivery Address Selected".i18n
          : "No Delivery Address Found".i18n,
      description: selection
          ? "Please select a delivery address".i18n
          : "When you add delivery addresses, they will appear here".i18n,
    );
  }
}
