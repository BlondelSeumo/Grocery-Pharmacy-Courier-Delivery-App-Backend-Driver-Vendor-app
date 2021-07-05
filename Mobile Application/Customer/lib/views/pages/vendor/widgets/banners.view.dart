import 'package:flutter/material.dart';
import 'package:fuodz/view_models/vendor/banners.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/list_items/banner.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Banners extends StatelessWidget {
  const Banners({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BannersViewModel>.reactive(
      viewModelBuilder: () => BannersViewModel(context),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return model.isBusy
            ? BusyIndicator().centered().h(150)
            : CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  initialPage: 1,
                  height: 150.0,
                  disableCenter: true,
                ),
                items: model.banners.map(
                  (banner) {
                    return BannerListItem(
                      imageUrl: banner.imageUrl,
                      onPressed: () => model.bannerSelected(banner),
                    );
                  },
                ).toList(),
              );
      },
    );
  }
}
