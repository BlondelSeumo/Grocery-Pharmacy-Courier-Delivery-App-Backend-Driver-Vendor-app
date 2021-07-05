import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/views/pages/payment/custom_webview.page.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentViewModel extends MyBaseViewModel {
  refreshDataSet() {}
  //
  openWebpageLink(String url) async {
    //
    await AppService.navigatorKey.currentContext.push(
      (context) => CustomWebviewPage(
        selectedUrl: url,
      ),
    );

    //
    refreshDataSet();
  }
}
