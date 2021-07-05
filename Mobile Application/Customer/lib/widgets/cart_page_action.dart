import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:velocity_x/velocity_x.dart';

class PageCartAction extends StatelessWidget {
  const PageCartAction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      FlutterIcons.shopping_bag_fea,
      color: Colors.white,
      size: 30,
    )
        .badge(
          count: CartServices.productsInCart.length,
          size: 20,
          color: context.cardColor,
          textStyle: context.textTheme.bodyText1.copyWith(fontSize: 13),
        )
        .centered()
        .pOnly(right: 10)
        .onInkTap(() async {
      //
      await AppService.changeHomePageIndex();
      // viewContext.navigator.popUntil(ModalRoute.withName(AppRoutes.homeRoute));
      context.navigator.popUntil((route) => route.isFirst);
    });
  }
}
