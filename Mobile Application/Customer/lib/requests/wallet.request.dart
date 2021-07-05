import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/wallet.dart';
import 'package:fuodz/services/http.service.dart';

class WalletRequest extends HttpService {
  //
  Future<Wallet> walletBalance() async {
    final apiResult = await get(Api.walletBalance);
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return Wallet.fromJson(apiResponse.body);
    }

    throw apiResponse.message;
  }

  Future<String> walletTopup(String amount) async {
    final apiResult = await post(Api.walletTopUp, {"amount": amount});
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.body["link"];
    }

    throw apiResponse.message;
  }
}
