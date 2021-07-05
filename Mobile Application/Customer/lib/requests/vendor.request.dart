import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/services/http.service.dart';
import 'package:fuodz/services/location.service.dart';

class VendorRequest extends HttpService {
  //
  Future<List<Vendor>> topVendorsRequest({
    int page = 1,
    bool byLocation = false,
  }) async {
    final apiResult = await get(
      Api.topVendors,
      queryParameters: {
        "page": "$page",
        "latitude": byLocation
            ? LocationService?.currenctAddress?.coordinates?.latitude
            : null,
        "longitude": byLocation
            ? LocationService?.currenctAddress?.coordinates?.longitude
            : null,
      },
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Vendor.fromJson(jsonObject))
          .toList();
    }

    throw apiResponse.message;
  }

  Future<List<Vendor>> nearbyVendorsRequest({
    int page = 1,
    bool byLocation = false,
  }) async {
    final apiResult = await get(
      Api.vendors,
      queryParameters: {
        "page": "$page",
        "latitude": byLocation
            ? LocationService?.currenctAddress?.coordinates?.latitude
            : null,
        "longitude": byLocation
            ? LocationService?.currenctAddress?.coordinates?.longitude
            : null,
      },
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Vendor.fromJson(jsonObject))
          .toList();
    }

    throw apiResponse.message;
  }

  Future<Vendor> vendorDetails(int id) async {
    //
    final apiResult = await get("${Api.vendors}/$id");
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return Vendor.fromJson(apiResponse.body);
    }

    throw apiResponse.message;
  }

  Future<List<Vendor>> fetchParcelVendors({int packageTypeId}) async {
    final apiResult = await get(
      Api.vendors,
      queryParameters: {
        "type": "package",
        "package_type_id": "$packageTypeId",
      },
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data
          .map((jsonObject) => Vendor.fromJson(jsonObject))
          .toList();
    }

    throw apiResponse.message;
  }

  //
  Future<ApiResponse> rateVendor({
    int rating,
    String review,
    int orderId,
    int vendorId,
  }) async {
    //
    final apiResult = await post(
      Api.rating,
      {
        "order_id": orderId,
        "vendor_id": vendorId,
        "rating": rating,
        "review": review,
      },
    );
    return ApiResponse.fromResponse(apiResult);
  }

  Future<ApiResponse> rateDriver({
    int rating,
    String review,
    int orderId,
    int driverId,
  }) async {
    //
    final apiResult = await post(
      Api.rating,
      {
        "order_id": orderId,
        "driver_id": driverId,
        "rating": rating,
        "review": review,
      },
    );
    return ApiResponse.fromResponse(apiResult);
  }
}
