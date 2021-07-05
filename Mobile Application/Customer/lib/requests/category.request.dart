import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/services/http.service.dart';

class CategoryRequest extends HttpService {
  //
  Future<List<Category>> categories() async {
    final apiResult = await get(Api.categories);

    final apiResponse = ApiResponse.fromResponse(apiResult);

    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Category.fromJson(jsonObject))
          .toList();
    } else {
      throw apiResponse.message;
    }
  }
}
