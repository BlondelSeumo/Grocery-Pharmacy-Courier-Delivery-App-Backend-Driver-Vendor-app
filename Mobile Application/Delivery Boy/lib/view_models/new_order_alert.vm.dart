import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/models/new_order.dart';
import 'package:fuodz/requests/order.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class NewOrderAlertViewModel extends MyBaseViewModel {
  //
  OrderRequest orderRequest = OrderRequest();
  NewOrder newOrder;
  bool canDismiss = false;
  CountDownController countDownTimerController = CountDownController();
  NewOrderAlertViewModel(this.newOrder);
  final assetsAudioPlayer = AssetsAudioPlayer();

  initialise() {

    //
    assetsAudioPlayer.open(
      Audio("assets/audio/alert.mp3"),
      loopMode: LoopMode.single,
    );
    //
    countDownTimerController.start();
    assetsAudioPlayer.play();

  }

  void processOrderAcceptance() async {
    setBusy(true);
    try {
      await orderRequest.acceptNewOrder(newOrder.id);
      assetsAudioPlayer.stop();
      AppService.navigatorKey.currentContext.pop(true);
      return;
    } catch (error) {
      print("Error ==> $error");
      AppService.navigatorKey.currentContext.showToast(
        msg: "$error",
        bgColor: Colors.red,
      );
    }
    setBusy(false);
    if (canDismiss) {
      assetsAudioPlayer.stop();
      AppService.navigatorKey.currentContext.pop();
    }
  }
}
