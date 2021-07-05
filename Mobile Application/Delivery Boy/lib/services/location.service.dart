import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/widgets/bottomsheets/location_permission.bottomsheet.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geocoder/geocoder.dart';

class LocationService {
  //
  static Location location = new Location();
  static DeliveryAddress currentLocation;
  static bool serviceEnabled;
  static PermissionStatus _permissionGranted;
  static FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  static BehaviorSubject<bool> locationDataAvailable = BehaviorSubject<bool>.seeded(false);

  //
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
    location.onLocationChanged.listen((LocationData mCurrentLocation) async {
      // Use current location
      if (currentLocation == null) {
        currentLocation = DeliveryAddress();
        locationDataAvailable.add(true);
      }

      final coordinates = new Coordinates(
        mCurrentLocation.latitude,
        mCurrentLocation.longitude,
      );
      //
      final addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates,
      );
      currentLocation.city = addresses.first.locality;
      currentLocation.latitude = mCurrentLocation.latitude;
      currentLocation.longitude = mCurrentLocation.longitude;
      //
      syncLocationWithFirebase(mCurrentLocation);
    });
  }

  //
  static syncLocationWithFirebase(LocationData currentLocation) async {
    final driverId = (await AuthServices.getCurrentUser()).id.toString();
    //
    if (AppService.driverIsOnline) {
      print("Send to fcm");
      firebaseFireStore.collection("drivers").doc(driverId).set(
        {
          "lat": currentLocation.latitude,
          "long": currentLocation.longitude,
        },
      );
    }
  }
}
