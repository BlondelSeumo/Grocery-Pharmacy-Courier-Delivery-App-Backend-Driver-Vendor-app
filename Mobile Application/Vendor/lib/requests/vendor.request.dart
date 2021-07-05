import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/http.service.dart';

class VendorRequest extends HttpService {
  //
  Future<dynamic> getVendorDetails() async {

    final vendorId = (await AuthServices.getCurrentUser(force: true)).vendor_id;
    final apiResult = await get(
      Api.vendorDetails.replaceFirst("id", vendorId.toString()),
    );

    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.body;
    } else {
      throw apiResponse.message;
    }
  }
}
