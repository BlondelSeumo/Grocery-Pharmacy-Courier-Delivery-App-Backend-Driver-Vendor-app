import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:stacked/stacked.dart';
import 'package:firestore_repository/firestore_repository.dart';

class MyBaseViewModel extends BaseViewModel {
  //
  BuildContext viewContext;
  final formKey = GlobalKey<FormState>();
  final formBuilderKey = GlobalKey<FormBuilderState>();
  final currencySymbol = AppStrings.currencySymbol;
  DeliveryAddress deliveryaddress = DeliveryAddress();
  String firebaseVerificationId;

   void initialise() {
    FirestoreRepository();
  }

}
