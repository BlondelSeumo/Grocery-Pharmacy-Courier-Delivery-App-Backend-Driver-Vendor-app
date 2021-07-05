import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/models/currency.dart';
import 'package:fuodz/models/earning.dart';
import 'package:fuodz/requests/earning.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';

class EarningViewModel extends MyBaseViewModel {
  //
  EarningRequest earningRequest = EarningRequest();
  Currency currency;
  Earning earning;

  EarningViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void initialise() async {
    //
    fetchEarning();
  }

  fetchEarning() async {
    setBusy(true);
    try {
      final results = await earningRequest.getEarning();
      currency = results[0];
      earning = results[1];
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }
}
