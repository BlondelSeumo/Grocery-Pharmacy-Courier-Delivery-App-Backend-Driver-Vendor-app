import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/view_models/onboarding.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.nonReactive(
      viewModelBuilder: () => OnboardingViewModel(context),
      builder: (context, model, child) {
        return BasePage(
          showAppBar: false,
          showLeadingAction: false,
          body: OnBoard(
            onBoardData: model.onBoardData,
            pageController: model.pageController,
            onSkip: model.onDonePressed,
            onDone: model.onDonePressed,
            titleStyles: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(fontSize: Vx.dp24),
            descriptionStyles: Theme.of(context).textTheme.bodyText1,
            pageIndicatorStyle: PageIndicatorStyle(
              width: 100,
              inactiveColor: Colors.grey,
              activeColor: AppColor.primaryColor,
              inactiveSize: Size(8, 8),
              activeSize: Size(12, 12),
            ),
            skipButton: TextButton(
              onPressed: model.onDonePressed,
              child: "Skip".text.color(AppColor.primaryColor).make(),
            ),
            nextButton: Consumer<OnBoardState>(
              builder:
                  (BuildContext context, OnBoardState state, Widget child) {
                return CustomButton(
                  title: state.isLastPage ? "Done" : "Next",
                  onPressed: () => _onNextTap(
                      model.pageController, model.onDonePressed, state),
                ).wTwoThird(context);
              },
            ),
          ),
        );
      },
    );
  }

  void _onNextTap(pageController, onDonePressed, OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      pageController.animateToPage(
        onBoardState.page + 1,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      onDonePressed();
    }
  }
}
