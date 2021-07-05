import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/models/product_category.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/http.service.dart';

class ProductRequest extends HttpService {
  //
  Future<List<Product>> getProducts({
    String keyword,
    int page = 1,
  }) async {
    final apiResult = await get(
      Api.products,
      queryParameters: {
        "keyword": keyword,
        "type": "vendor",
        "page": page,
      },
    );
    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data.map((jsonObject) {
        return Product.fromJson(jsonObject);
      }).toList();
    } else {
      throw apiResponse.message;
    }
  }

  //
  Future<Product> getProductDetails(int productId) async {
    final apiResult = await get(
      Api.products + "/$productId",
    );
    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return Product.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message;
    }
  }

  Future<List<ProductCategory>> getProductCategories(
      {bool subCat = false}) async {
    final apiResult = await get(
      Api.productCategories,
      queryParameters: {
        "type": subCat ? "sub" : "",
      },
    );
    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data.map((jsonObject) {
        return ProductCategory.fromJson(jsonObject);
      }).toList();
    } else {
      throw apiResponse.message;
    }
  }

  Future<ApiResponse> newProduct(Map<String, dynamic> value,
      {File photo}) async {
    //
    final postBody = {
      ...value,
      "photo": photo != null
          ? await MultipartFile.fromFile(
              photo.path,
            )
          : null,
      "vendor_id": AuthServices.currentVendor.id,
    };
    final apiResult = await postWithFiles(
      Api.products,
      postBody,
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }

  Future<ApiResponse> deleteProduct(
    Product product,
  ) async {
    final apiResult = await delete(
      Api.products + "/${product.id}",
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }

  Future<ApiResponse> updateDetails(
    Product product, {
    Map<String, dynamic> data = null,
    File photo,
  }) async {
    //
    final postBody = {
      "_method": "PUT",
      ...(data == null ? product.toJson() : data),
      "photo": photo != null
          ? await MultipartFile.fromFile(
              photo.path,
            )
          : null,
      "vendor_id": AuthServices.currentVendor.id,
    };
    final apiResult = await postWithFiles(
      Api.products + "/${product.id}",
      postBody,
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }
}
