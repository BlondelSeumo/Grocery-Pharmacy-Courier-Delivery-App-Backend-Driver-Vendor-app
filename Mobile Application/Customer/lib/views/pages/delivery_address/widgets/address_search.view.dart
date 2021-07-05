import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/constants/input.styles.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/delivery_address/base_delivery_addresses.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:fuodz/translations/delivery_address/new_delivery_address.i18n.dart';

class AddressSearchView extends StatefulWidget {
  const AddressSearchView(
    this.vm, {
    Key key,
    this.addressSelected,
    this.selectOnMap,
  }) : super(key: key);

  //
  final BaseDeliveryAddressesViewModel vm;
  final Function(Prediction) addressSelected;
  final Function selectOnMap;

  @override
  _AddressSearchViewState createState() => _AddressSearchViewState();
}

class _AddressSearchViewState extends State<AddressSearchView> {
  //
  bool isLoading = false;

  //
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //search bar
        GooglePlaceAutoCompleteTextField(
          textEditingController: widget.vm.placeSearchTEC,
          googleAPIKey: AppStrings.googleMapApiKey,
          inputDecoration: InputDecoration(
            // labelText: "Address",
            hintText: "Enter your address...".i18n,
            enabledBorder: InputStyles.inputUnderlineEnabledBorder(),
            errorBorder: InputStyles.inputUnderlineEnabledBorder(),
            focusedErrorBorder: InputStyles.inputUnderlineFocusBorder(),
            focusedBorder: InputStyles.inputUnderlineFocusBorder(),
            prefixIcon: Icon(
              FlutterIcons.search_fea,
              size: 18,
            ),
            // suffixIcon: ,
            labelStyle: Theme.of(context).textTheme.bodyText1,
            contentPadding: EdgeInsets.all(10),
          ),
          debounceTime: 800, // default 600 ms,
          // countries: (AppStrings.countryCode != null &&
          //         AppStrings.countryCode.isNotBlank)
          //     ? [AppStrings.countryCode]
          //     : null,
          countries: null, // optional by default null is set
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            // this method will return latlng with place detail
            setState(() {
              isLoading = false;
            });
            context.pop();
            widget.addressSelected(prediction);
            widget.vm.placeSearchTEC.clear();
          }, // this callback is called when isLatLngRequired is true
          itmClick: (Prediction prediction) {
            // //
            widget.vm.placeSearchTEC.text = prediction.description;
            widget.vm.placeSearchTEC.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description.length),
            );
            //
            setState(() {
              isLoading = true;
            });
          },
        ),
        //
        isLoading ? BusyIndicator().centered().p20() : UiSpacer.emptySpace(),
        //
        UiSpacer.expandedSpace(),
        //
        CustomButton(
          title: "Pick On Map".i18n,
          onPressed: () {
            print("done");
            context.pop();
            widget.selectOnMap();
          },
        ),
      ],
    ).p20().h(context.percentHeight * 90);
  }
}
