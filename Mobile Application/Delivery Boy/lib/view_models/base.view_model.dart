import 'package:firebase_chat/firebase_chat.dart';
import 'package:firebase_chat/models/chat_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:stacked/stacked.dart';
import 'package:firestore_repository/firestore_repository.dart';

class MyBaseViewModel extends BaseViewModel {
  //
  BuildContext viewContext;
  final formKey = GlobalKey<FormState>();
  final currencySymbol = AppStrings.currencySymbol;
  DeliveryAddress deliveryaddress = DeliveryAddress();
  String firebaseVerificationId;
  ChatEntity chatEntity;

  //

  void initialise() {
    FirestoreRepository();
  }

  //
}
