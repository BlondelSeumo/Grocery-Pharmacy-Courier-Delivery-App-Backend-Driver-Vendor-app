import 'package:flutter/material.dart';
import 'package:fuodz/view_models/vendor/categories.vm.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/category.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/categories.i18n.dart';

class Categories extends StatelessWidget {
  const Categories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesViewModel>.reactive(
      viewModelBuilder: () => CategoriesViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return VStack(
          [
            //
            "Categories".i18n.text.xl.semiBold.make().p12(),

            //categories list
            CustomListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              dataSet: model.categories,
              isLoading: model.isBusy,
              itemBuilder: (context, index) {
                //
                return CategoryListItem(
                  category: model.categories[index],
                  onPressed: model.categorySelected,
                );
              },
            ).h(Vx.dp64 * 2),
          ],
        );
      },
    );
  }
}
