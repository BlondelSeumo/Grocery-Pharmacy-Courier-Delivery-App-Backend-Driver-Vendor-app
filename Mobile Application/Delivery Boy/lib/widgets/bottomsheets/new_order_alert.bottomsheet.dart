import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/new_order.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_order_alert.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/home.i18n.dart';

class NewOrderAlertBottomSheet extends StatefulWidget {
  NewOrderAlertBottomSheet(
    this.newOrder, {
    Key key,
  }) : super(key: key);

  final NewOrder newOrder;
  @override
  _NewOrderAlertBottomSheetState createState() =>
      _NewOrderAlertBottomSheetState();
}

class _NewOrderAlertBottomSheetState extends State<NewOrderAlertBottomSheet> {
  //
  bool started = false;
  NewOrderAlertViewModel vm;

  //
  @override
  void initState() {
    super.initState();
    vm = NewOrderAlertViewModel(widget.newOrder);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      started = true;
      vm.initialise();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewOrderAlertViewModel>.reactive(
      viewModelBuilder: () => vm,
      builder: (context, vm, child) {
        return VStack(
          [
            HStack(
              [
                //title
                "New Order Alert".i18n.text.semiBold.xl2.make().py12().expand(),

                //countdown
                CircularCountDownTimer(
                  duration: 15,
                  controller: vm.countDownTimerController,
                  initialDuration: 0,
                  width: 30,
                  height: 30,
                  ringColor: Colors.grey[300],
                  ringGradient: null,
                  fillColor: AppColor.accentColor,
                  fillGradient: null,
                  backgroundColor: AppColor.primaryColorDark,
                  backgroundGradient: null,
                  strokeWidth: 4.0,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: false,
                  onStart: () {
                    print('Countdown Started');
                  },
                  onComplete: () {
                    print('Countdown Ended');
                    if (started) {
                      if (vm.isBusy) {
                        vm.canDismiss = true;
                      } else {
                        vm.assetsAudioPlayer.stop();
                        context.pop();
                      }
                    }
                  },
                ),
              ],
            ),
            "Pickup Location".i18n.text.make(),
            "${widget.newOrder.pickup.address} (${widget.newOrder.distance.numCurrency}km)"
                .text
                .semiBold
                .xl
                .make(),
            UiSpacer.verticalSpace(space: 10),
            //
            "Dropoff Location".i18n.text.make(),
            "${widget.newOrder.dropoff.address} (${widget.newOrder.orderDistance.numCurrency}km)"
                .text
                .semiBold
                .xl
                .make(),
            UiSpacer.verticalSpace(space: 10),
            //fee
            "Delivery Fee".i18n.text.make(),
            "${AppStrings.currencySymbol} ${widget.newOrder.amount.numCurrency}"
                .text
                .semiBold
                .xl
                .make(),
            UiSpacer.verticalSpace(),

            Visibility(
              visible: widget.newOrder.isParcel,
              child: VStack(
                [
                  "Package Type".i18n.text.make(),
                  "${widget.newOrder.packageType}".text.semiBold.xl.make(),
                  UiSpacer.verticalSpace(),
                ],
              ),
            ),
            SwipingButton(
              height: 50,
              backgroundColor: AppColor.accentColor.withOpacity(0.50),
              swipeButtonColor: AppColor.primaryColorDark,
              swipePercentageNeeded: 0.80,
              text: "Accept".i18n,
              onSwipeCallback: vm.processOrderAcceptance,
            ).wFull(context).box.make().h(vm.isBusy ? 0 : 50),
            vm.isBusy
                ? BusyIndicator().centered().p20()
                : UiSpacer.emptySpace(),
            "Swipe to accept order".i18n.text.makeCentered().py4(),
            UiSpacer.verticalSpace(),
          ],
        ).p20().scrollVertical();
      },
    );
  }
}
