import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {this.imageUrl, this.height = Vx.dp40, this.width, this.boxFit, Key key})
      : super(key: key);

  final String imageUrl;
  final double height;
  final double width;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: this.imageUrl,
      fit: this.boxFit ?? BoxFit.cover,
      progressIndicatorBuilder: (context, imageURL, progress) =>
          BusyIndicator().centered(),
    ).h(this.height).w(this.width ?? context.percentWidth);
  }
}
