import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/requests/category.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoriesViewModel extends MyBaseViewModel {
  CategoriesViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  CategoryRequest _categoryRequest = CategoryRequest();

  //
  List<Category> categories = [];

  //
  initialise() async {
    setBusy(true);
    try {
      categories = await _categoryRequest.categories();
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  //
  categorySelected(Category category) async {
    viewContext.navigator.pushNamed(
      AppRoutes.search,
      arguments: Search(category: category),
    );
  }
}
