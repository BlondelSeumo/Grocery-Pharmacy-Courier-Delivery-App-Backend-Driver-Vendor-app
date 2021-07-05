import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/services/http.service.dart';

class ProductRequest extends HttpService {
  //
  Future<List<Product>> bestProductsRequest({int page = 1}) async {
    final apiResult = await get(
      Api.bestProducts,
      queryParameters: {"page": "$page"},
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    }

    throw apiResponse.message;
  }

  Future<List<Product>> forYouProductsRequest({int page = 1}) async {
    final apiResult = await get(
      Api.forYouProducts,
      queryParameters: {"page": "$page"},
    );
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    }

    throw apiResponse.message;
  }

  Future<List<Product>> searchProduct(
      {int page = 1, String keyword, String type, Category category}) async {
    final apiResult = await get(
      Api.forYouProducts,
      queryParameters: {"page": "$page"},
    );
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    }

    throw apiResponse.message;
  }

  //
  Future<Product> productDetails(int id) async {
    //
    final apiResult = await get("${Api.products}/$id");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return Product.fromJson(apiResponse.body);
    }

    throw apiResponse.message;
  }

}
