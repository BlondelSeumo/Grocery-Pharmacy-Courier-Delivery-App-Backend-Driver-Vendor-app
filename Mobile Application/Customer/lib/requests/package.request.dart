import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/package_checkout.dart';
import 'package:fuodz/models/package_type.dart';
import 'package:fuodz/services/http.service.dart';

class PackageRequest extends HttpService {
  //
  Future<List<PackageType>> fetchPackageTypes() async {
    final apiResult = await get(Api.packageTypes);
    final apiResponse = ApiResponse.fromResponse(apiResult);

    if (apiResponse.allGood) {
      return (apiResponse.body as List).map((jsonObject) {
        return PackageType.fromJson(jsonObject);
      }).toList();
    } else {
      throw apiResponse.message;
    }
  }

  //
  Future<PackageCheckout> parcelSummary({
    int vendorId,
    int packageTypeId,
    int pickupLocationId,
    int dropoffLocationId,
    String packageWeight,
    List<DeliveryAddress> stops,
  }) async {
    //
    final locationStops =
        stops != null ? stops.map((e) => {"id": e.id}).toList() : [];
    locationStops.insert(0, {"id": pickupLocationId});

    //
    final apiResult = await get(
      Api.packageOrderSummary,
      queryParameters: {
        "vendor_id": "${vendorId}",
        "package_type_id": "${packageTypeId}",
        "pickup_location_id": "${pickupLocationId}",
        "weight": "${packageWeight}",
        "dropoff_location_id":
            stops != null ? "${stops.last.id}" : "${dropoffLocationId}",
        "stops": stops != null ? locationStops : [],
      },
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return PackageCheckout.fromJson(apiResponse.body);
    }

    throw apiResponse.message;
  }
}
