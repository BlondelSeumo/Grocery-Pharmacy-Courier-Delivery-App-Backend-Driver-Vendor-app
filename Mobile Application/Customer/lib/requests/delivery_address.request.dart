import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/services/http.service.dart';

class DeliveryAddressRequest extends HttpService {
  //
  Future<List<DeliveryAddress>> getDeliveryAddresses({int vendorId}) async {
    final apiResult = await get(
      Api.deliveryAddresses,
      queryParameters: {
        "vendor_id": vendorId,
      },
    );

    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data.map((jsonObject) {
        return DeliveryAddress.fromJson(jsonObject);
      }).toList();
    } else {
      throw apiResponse.message;
    }
  }

  //
  Future<DeliveryAddress> preselectedDeliveryAddress({int vendorId}) async {
    final apiResult = await get(
      Api.deliveryAddresses,
      queryParameters: {
        "action": "default",
        "vendor_id": vendorId,
      },
    );

    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.body.toString().isNotEmpty ? DeliveryAddress.fromJson(apiResponse.body): null;
    } else {
      throw apiResponse.message;
    }
  }

  //
  Future<ApiResponse> deleteDeliveryAddress(
      DeliveryAddress deliveryAddress) async {
    final apiResult = await delete(
      Api.deliveryAddresses + "/" + deliveryAddress.id.toString(),
    );

    //
    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> saveDeliveryAddress(
      DeliveryAddress deliveryAddress) async {
    //
    final apiResult = await post(
      Api.deliveryAddresses,
      deliveryAddress.toSaveJson(),
    );

    //
    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> updateDeliveryAddress(
    DeliveryAddress deliveryAddress,
  ) async {
    //
    final apiResult = await patch(
      Api.deliveryAddresses + "/" + deliveryAddress.id.toString(),
      deliveryAddress.toSaveJson(),
    );

    //
    return ApiResponse.fromResponse(apiResult);
  }
}
