import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/widgets/states/empty.state.dart';
import 'package:fuodz/translations/product.i18n.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyProduct extends StatelessWidget {
  const EmptyProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      imageUrl: AppImages.emptyCart,
      title: "No Product".i18n,
      description: "All products will appear here".i18n,
    ).p20().centered();
  }
}