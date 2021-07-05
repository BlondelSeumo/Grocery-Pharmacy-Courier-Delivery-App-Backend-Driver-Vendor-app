import 'package:flutter/material.dart';
import 'package:fuodz/view_models/earning.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/profile.i18n.dart';

class EarningBottomSheet extends StatelessWidget {
  const EarningBottomSheet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EarningViewModel>.reactive(
      viewModelBuilder: () => EarningViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return VStack(
          [
            "Earning".i18n.text.medium.xl2.makeCentered(),
            vm.isBusy
                ? BusyIndicator().centered().p20().expand()
                : VStack(
                    [
                      //amount
                      HStack(
                        [
                          //currency
                          vm.currency.symbol.text.medium.xl.make().px4(),
                          //earning
                          vm.earning.amount.numCurrency.text.semiBold.xl3.make(),
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                        alignment: MainAxisAlignment.center,
                      ).py12(),
                      //updated at
                      vm.earning.formattedUpdatedDate.text.medium.lg.makeCentered(),
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                        alignment: MainAxisAlignment.center,
                  ),
          ],
          
        ).p20().hOneThird(context);
      },
    );
  }
}
