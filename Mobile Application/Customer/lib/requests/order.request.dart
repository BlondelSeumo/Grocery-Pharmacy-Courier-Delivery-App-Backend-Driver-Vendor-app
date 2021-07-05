import 'package:flutter/material.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/services/http.service.dart';

class OrderRequest extends HttpService {
  //
  Future<List<Order>> getOrders({int page = 1}) async {
    final apiResult = await get(
      Api.orders,
      queryParameters: {
        "page": page,
      },
    );

    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data.map((jsonObject) {
        return Order.fromJson(jsonObject);
      }).toList();
    } else {
      throw apiResponse.message;
    }
  }

  //
  Future<Order> getOrderDetails({@required int id}) async {
    final apiResult = await get(Api.orders + "/$id");
    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return Order.fromJson(apiResponse.body);
    } else {
      throw apiResponse.message;
    }
  }

  //
  Future<String> updateOrder({int id, String status, String reason}) async {
    final apiResult = await patch(Api.orders + "/$id", {
      "status": status,
      "reason": reason,
    });
    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.message;
    } else {
      throw apiResponse.message;
    }
  }
}
