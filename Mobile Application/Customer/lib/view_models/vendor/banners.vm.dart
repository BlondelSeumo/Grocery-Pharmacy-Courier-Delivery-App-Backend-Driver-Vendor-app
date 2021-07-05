import 'package:flutter/material.dart' hide Banner;
import 'package:fuodz/models/banner.dart';
import 'package:fuodz/requests/banner.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/search.dart';
import 'package:velocity_x/velocity_x.dart';

class BannersViewModel extends MyBaseViewModel {
  BannersViewModel(BuildContext context) {
    this.viewContext = context;
  }
  //
  BannerRequest _bannerRequest = BannerRequest();
  //
  List<Banner> banners = [];

  //
  initialise() async {
    setBusy(true);
    try {
      banners = await _bannerRequest.banners();
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  //
  bannerSelected(Banner banner) {
    viewContext.navigator.pushNamed(
      AppRoutes.search,
      arguments: Search(category: banner.category),
    );
  }
}
