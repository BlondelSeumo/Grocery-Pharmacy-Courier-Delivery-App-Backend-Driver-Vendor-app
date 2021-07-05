import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/view_models/search.vm.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/search.i18n.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader(this.model, {Key key}) : super(key: key);

  final SearchViewModel model;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //Appbar
        HStack(
          [
            VStack(
              [
                "Search".i18n.text.semiBold.xl2.make(),
                "Ordered by Nearby first".i18n.text.make(),
              ],
            ).expand(),

            //
            Icon(
              FlutterIcons.close_ant,
            ).p4().onInkTap(context.pop),
          ],
        ).pOnly(bottom: 20),
        //
        CustomTextFormField(
          prefixIcon: Icon(FlutterIcons.search_fea, size: 20),
          hintText: "Search".i18n,
          textEditingController: model.keywordTEC,
          onFieldSubmitted: model.startSearch,
        ),
      ],
    );
  }
}
