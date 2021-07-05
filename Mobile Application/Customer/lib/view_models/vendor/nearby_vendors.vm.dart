import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/requests/vendor.request.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class NearbyVendorsViewModel extends MyBaseViewModel {
  NearbyVendorsViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  List<Vendor> vendors = [];

  int selectedType = 1;

  //
  VendorRequest _vendorRequest = VendorRequest();

  //
  initialise() {
    //
    fetchTopVendors();

    //
    LocationService.currenctAddressSubject.listen((value) {
      //
      fetchTopVendors();
    });
  }

  //
  fetchTopVendors() async {

    if( LocationService?.currenctAddress?.coordinates?.latitude == null ){
      return;
    }
    setBusy(true);
    try {
      //filter by location if user selects delivery address
      vendors = await _vendorRequest.nearbyVendorsRequest(
        byLocation: true,
      );

      //
      if (selectedType == 2) {
        vendors = vendors.filter((e) => e.pickup == 1).toList();
      } else if (selectedType == 1) {
        vendors = vendors.filter((e) => e.delivery == 1).toList();
      }
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  //
  changeType(int type) {
    selectedType = type;
    fetchTopVendors();
  }

  vendorSelected(Vendor vendor) async {
    viewContext.navigator.pushNamed(
      AppRoutes.vendorDetails,
      arguments: vendor,
    );
  }
}
