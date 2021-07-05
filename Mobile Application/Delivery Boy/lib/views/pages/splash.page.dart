import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/view_models/splash.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/splash.i18n.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: () => SplashViewModel(context),
        onModelReady: (vm)=> vm.initialise(),
        builder: (context, model, child) {
          return VStack(
            [
              //
              Image.asset(AppImages.appLogo)
                  .wh(Vx.dp64, Vx.dp64)
                  .box
                  .clip(Clip.antiAlias)
                  .roundedSM
                  .makeCentered().py12(),
              "Loading Please wait...".i18n.text.makeCentered(),
            ],
          ).centered();
        },
      ),
    );
  }
}
