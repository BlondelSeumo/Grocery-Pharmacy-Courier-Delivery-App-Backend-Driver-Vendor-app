import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/banner.dart';
import 'package:fuodz/services/http.service.dart';

class BannerRequest extends HttpService {
  //
  Future<List<Banner>> banners() async {
    final apiResult = await get(Api.banners);

    final apiResponse = ApiResponse.fromResponse(apiResult);

    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Banner.fromJSON(jsonObject))
          .toList();
    } else {
      throw apiResponse.message;
    }
  }
}
