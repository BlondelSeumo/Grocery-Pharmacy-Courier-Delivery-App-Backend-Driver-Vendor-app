import 'package:flutter/cupertino.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/requests/search.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchViewModel extends MyBaseViewModel {
  //
  SearchRequest _searchRequest = SearchRequest();
  TextEditingController keywordTEC = TextEditingController();
  ScrollController scrollController = ScrollController();
  String type = "";
  Category category;
  //
  List<Product> products = [];
  List<Vendor> vendors = [];
  List<dynamic> searchResults = [];
  bool filterByProducts = true;

  SearchViewModel(BuildContext context, Search search) {
    this.viewContext = context;
    this.category = search?.category;
    this.type = search?.type;
    //
    startSearch("", clear: false);
  }

  //
  startSearch(String keyword, {bool clear = true}) async {
    //refresh search criteria
    if (clear) {
      category = null;
      type = null;
    }

    setBusy(true);

    //
    try {
      final searchResult = await _searchRequest.searchRequest(
        keyword: keyword,
        category_id: category != null ? category.id.toString() : null,
        type: type,
      );
      clearErrors();

      //
      products = searchResult[0];
      vendors = searchResult[1];

      if (filterByProducts) {
        searchResults = products;
      } else {
        searchResults = vendors;
      }
    } catch (error) {
      print("Error ==> $error");
      setError(error);
    }

    //done loading data
    setBusy(false);
  }

  //
  void showFilter() {}

  //
  productSelected(Product product) async {
    viewContext.navigator.pushNamed(
      AppRoutes.product,
      arguments: product,
    );
  }

  //
  vendorSelected(Vendor vendor) async {
    viewContext.navigator.pushNamed(
      AppRoutes.vendorDetails,
      arguments: vendor,
    );
  }

  void enableProductFilter() {
    filterByProducts = true;
    searchResults = products;
    scrollController.animToTop();
    notifyListeners();
  }

  void enableVendorFilter() {
    filterByProducts = false;
    searchResults = vendors;
    scrollController.animToTop();
    notifyListeners();
  }
}
