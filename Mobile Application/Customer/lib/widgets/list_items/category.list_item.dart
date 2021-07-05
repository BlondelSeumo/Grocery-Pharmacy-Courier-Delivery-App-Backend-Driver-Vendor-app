import 'package:flutter/material.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({this.category, this.onPressed, Key key})
      : super(key: key);

  final Function(Category) onPressed;
  final Category category;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        CustomImage(
          imageUrl: category.imageUrl,
          boxFit: BoxFit.fill,
          width: Vx.dp56,
          height: Vx.dp56,
        ).p8().centered().card.make(),
        //
        category.name.text.medium.lg
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .makeCentered(),
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).onInkTap(
      () => this.onPressed(this.category),
    );
  }
}
