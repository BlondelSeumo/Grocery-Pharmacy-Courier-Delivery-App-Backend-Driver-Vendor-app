import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/models/wallet.dart';
import 'package:fuodz/requests/wallet.request.dart';
// import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/view_models/payment.view_model.dart';
import 'package:fuodz/widgets/bottomsheets/wallet_amount_entry.bottomsheet.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class WalletViewModel extends PaymentViewModel {
  //
  WalletViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  WalletRequest walletRequest = WalletRequest();
  Wallet wallet;

  //
  getWalletBalance() async {
    setBusy(true);
    try {
      wallet = await walletRequest.walletBalance();
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  //
  showAmountEntry() {
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      builder: (context) {
        return WalletAmountEntryBottomSheet(
          onSubmit: (String amount) {
            viewContext.pop();
            initiateWalletTopUp(amount);
          },
        );
      },
    );
  }

  //
  initiateWalletTopUp(String amount) async {
    setBusy(true);

    try {
      final link = await walletRequest.walletTopup(amount);
      openWebpageLink(link);
      // await launch(
      //   link,
      //   forceSafariVC: true,
      //       forceWebView: true,
      //       enableJavaScript: true,
      // enableDomStorage: true,
      // );
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
    
  }
}
