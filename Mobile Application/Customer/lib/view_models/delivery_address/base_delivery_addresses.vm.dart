import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/requests/delivery_address.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/views/pages/delivery_address/widgets/address_search.view.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:what3words/what3words.dart' hide Coordinates;
import 'package:velocity_x/velocity_x.dart';
import 'package:supercharged/supercharged.dart';

class BaseDeliveryAddressesViewModel extends MyBaseViewModel {
  //
  DeliveryAddressRequest deliveryAddressRequest = DeliveryAddressRequest();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController placeSearchTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController what3wordsTEC = TextEditingController();
  bool isDefault = false;
  DeliveryAddress deliveryAddress;
  What3WordsV3 what3WordsV3Api = What3WordsV3(AppStrings.what3wordsApiKey);

  //
  openLocationPicker() async {
    //
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        return AddressSearchView(
          this,
          addressSelected: (Prediction prediction) async {
            addressTEC.text = prediction.description;
            deliveryAddress.address = prediction.description;
            deliveryAddress.latitude = prediction.lat.toDouble();
            deliveryAddress.longitude = prediction.lng.toDouble();
            //
            setBusy(true);
            await getLocationCityName(deliveryAddress);
            setBusy(false);
          },
          selectOnMap: showAddressLocationPicker,
        );
      },
    );
  }

  //
  showAddressLocationPicker() {}

  Future<DeliveryAddress> getLocationCityName(DeliveryAddress deliveryAddress) async {
    final coordinates =
        new Coordinates(deliveryAddress.latitude, deliveryAddress.longitude);
    final addresses = await Geocoder.local.findAddressesFromCoordinates(
      coordinates,
    );

    //
    print("Address countryName ==> ${addresses.first.countryName}");
    print("Address subLocality ==> ${addresses.first.subLocality}");
    print("Address locality ==> ${addresses.first.locality}");
    print("Address adminArea ==> ${addresses.first.adminArea}");
    print("Address subAdminArea ==> ${addresses.first.subAdminArea}");
    deliveryAddress.city = addresses.first.locality;
    deliveryAddress.state = addresses.first.adminArea;
    deliveryAddress.country = addresses.first.countryName;
    return deliveryAddress;
  }

  //
  validateWhat3words(String value) async {
    //
    var coordinates =
        await what3WordsV3Api.convertToCoordinates(value).execute();

    //
    if (coordinates.isSuccessful()) {
      // print('Coordinates ${coordinates.toJson()}');
      addressTEC.text = coordinates.toJson()["nearestPlace"];
      deliveryAddress.address = coordinates.toJson()["nearestPlace"];
      deliveryAddress.latitude = coordinates.toJson()["coordinates"]["lat"];
      deliveryAddress.longitude = coordinates.toJson()["coordinates"]["lng"];
      // From coordinates
      setBusy(true);
      final locationCoordinates = new Coordinates(
        deliveryAddress.latitude,
        deliveryAddress.longitude,
      );
      //
      final addresses = await Geocoder.local.findAddressesFromCoordinates(
        locationCoordinates,
      );
      deliveryAddress.city = addresses.first.locality;
      setBusy(false);
    } else {
      //
      var error = coordinates.getError();
      viewContext.showToast(msg: error.message, bgColor: Colors.red);
      if (error == What3WordsError.BAD_WORDS) {
        // The three word address provided is invalid
        print('BadWords: ${error.message}');
      } else if (error == What3WordsError.INTERNAL_SERVER_ERROR) {
        // Server Error
        print('InternalServerError: ${error.message}');
      } else if (error == What3WordsError.NETWORK_ERROR) {
        // Network Error
        print('NetworkError: ${error.message}');
      } else {
        print('${error.code} : ${error.message}');
      }
    }
  }

  void shareWhat3words() {
    launch("https://what3words.com/");
  }
}
