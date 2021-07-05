import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/widgets/states/empty.state.dart';
import 'package:fuodz/translations/vendor.i18n.dart';

class EmptyProduct extends StatelessWidget {
  const EmptyProduct({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      imageUrl: AppImages.noProduct,
      title: "No Product Found".i18n,
      description: "There seems to be no product".i18n,
    );
  }
}