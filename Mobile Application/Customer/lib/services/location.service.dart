import 'package:flutter/material.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/widgets/bottomsheets/location_permission.bottomsheet.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:rxdart/rxdart.dart';

class LocationService {
  //
  static Location location = new Location();

  static bool serviceEnabled;
  static PermissionStatus _permissionGranted;
  static LocationData _locationData;
  static Address currenctAddress;

  //
  static BehaviorSubject<Address> currenctAddressSubject =
      BehaviorSubject<Address>();
  // static Stream<Address> get currenctAddressStream =>
  //     _currenctAddressSubject.stream;

  static Future<void> prepareLocationListener() async {
    
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      //
      if (await showRequestDialog()) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    }

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    _startLocationListner();
  }

  static Future<bool> showRequestDialog() async {
    //
    var requestResult = false;
    //
    await showDialog(
      context: AppService.navigatorKey.currentContext,
      builder: (context) {
        return LocationPermissionDialog(onResult: (result) {
          requestResult = result;
        });
      },
    );

    //
    return requestResult;
  }

  static void _startLocationListner() async {
    //
    //update location every 100meters
    await location.changeSettings(distanceFilter: 100);

    //listen
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      _locationData = currentLocation;
      //
      geocodeCurrentLocation();
    });
  }

  //
  static geocodeCurrentLocation() async {
    if (_locationData != null) {
      final coordinates = new Coordinates(
        _locationData.latitude,
        _locationData.longitude,
      );

      try {
        //
        final addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates,
        );
        //
        currenctAddress = addresses.first;
        //
        currenctAddressSubject.add(currenctAddress);
      } catch (error) {
        print("Error get location ==> $error");
      }
    }
  }
}
