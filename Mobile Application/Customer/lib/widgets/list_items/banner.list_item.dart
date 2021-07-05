import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BannerListItem extends StatelessWidget {
  const BannerListItem({
    this.imageUrl,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final String imageUrl;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: this.imageUrl,
      fit: BoxFit.cover,
    )
        .onInkTap(this.onPressed)
        .box
        .roundedSM
        .clip(Clip.antiAlias)
        .margin(
          EdgeInsets.symmetric(horizontal: 5.0),
        )
        .make();
  }
}
