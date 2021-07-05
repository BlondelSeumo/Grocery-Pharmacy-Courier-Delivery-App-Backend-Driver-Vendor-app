import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/services/http.service.dart';
import 'package:fuodz/services/location.service.dart';

class SearchRequest extends HttpService {
  //
  Future<List<List<dynamic>>> searchRequest({
    String keyword = "",
    String category_id = null,
    String type = "",
  }) async {
    final apiResult = await get(Api.search, queryParameters: {
      "keyword": keyword,
      "category_id": category_id,
      "type": type,
      "latitude": LocationService?.currenctAddress?.coordinates?.latitude,
      "longitude": LocationService?.currenctAddress?.coordinates?.longitude,
    });

    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      //
      List<List> result = [];
      List<Product> products = [];
      List<Vendor> vendors = [];

      //
      products = (apiResponse.body["products"] as List)
          .map((jsonObject) => Product.fromJson(jsonObject))
          .toList();

      vendors = (apiResponse.body["vendors"] as List)
          .map((jsonObject) => Vendor.fromJson(jsonObject))
          .toList();

      //
      result.add(products);
      result.add(vendors);

      return result;
    }

    throw apiResponse.message;
  }
}
