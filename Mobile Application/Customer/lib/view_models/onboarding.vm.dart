import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/services/auth.service.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/onboarding.i18n.dart';

class OnboardingViewModel extends MyBaseViewModel {
  OnboardingViewModel(BuildContext context) {
    this.viewContext = context;
  }

  final PageController pageController = PageController();

  final List<OnBoardModel> onBoardData = [
    OnBoardModel(
      title: "Browse through different vendors".i18n,
      description: "Get your favourite meal/food/items from varities of vendor".i18n,
      imgUrl: AppImages.onboarding1,
    ),
    OnBoardModel(
      title: "Chat with vendor/delivery boy".i18n,
      description:
          "Call/Chat with vendor/delivery boy for update about your order and more".i18n,
      imgUrl: AppImages.onboarding2,
    ),
    OnBoardModel(
      title: "Delivery made easy".i18n,
      description:
          "Get your ordered food/item or parcel delivered at a very fast, cheap and reliable way".i18n,
      imgUrl: AppImages.onboarding3,
    ),
  ];

  void onDonePressed() async {
    //
    await AuthServices.firstTimeCompleted();
    viewContext.navigator.pushNamedAndRemoveUntil(
      AppRoutes.homeRoute,
      (route) => false,
    );
  }
}
