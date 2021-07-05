import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/welcome.vm.dart';
import 'package:fuodz/views/pages/vendor/vendor.page.dart';
import 'package:fuodz/views/pages/parcel/new_parcel.page.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/states/welcome.empty.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({
    Key key,
  }) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with AutomaticKeepAliveClientMixin<WelcomePage> {
  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    super.build(context);
    return BasePage(
      body: ViewModelBuilder<WelcomeViewModel>.reactive(
        viewModelBuilder: () => WelcomeViewModel(context),
        onModelReady: (vm) => vm.initialise(),
        builder: (context, vm, child) {
          return SafeArea(
            top: vm.selectedPage != 0 || vm.showOnlyOneSection(),
            child: VStack(
              [
                //back button
                vm.selectedPage != 0
                    ? AppBar(
                        title: vm.pageTitle.text
                            .color(context.textTheme.bodyText1.color)
                            .make(),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: Icon(
                          FlutterIcons.arrow_left_fea,
                          color: context.textTheme.bodyText1.color,
                        ).onInkTap(
                          () => vm.pageSelected(0, ""),
                        ),
                      )
                    : UiSpacer.emptySpace(),
                //
                vm.showOnlyOneSection()
                    //if only one is enable
                    ? (AppStrings.enableParcel
                        ? NewParcelPage(
                            onFinish: () => vm.pageSelected(0, ""),
                          ).expand()
                        : VendorPage().expand())
                    //if more than one is ennabled, allow user to chose
                    : vm.selectedPage == 0
                        ? EmptyWelcome(vm: vm)
                        : vm.selectedPage == 1
                            ? NewParcelPage(
                                onFinish: () => vm.pageSelected(0, ""),
                              ).expand()
                            : VendorPage().expand(),
              ],
            ).pOnly(top: vm.showOnlyOneSection() ? Vx.dp20 : Vx.dp0),
          );
        },
      ),
    );
  }
}
