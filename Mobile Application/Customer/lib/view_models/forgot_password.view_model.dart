import 'package:cool_alert/cool_alert.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/widgets/bottomsheets/account_verification_entry.dart';
import 'package:fuodz/widgets/bottomsheets/new_password_entry.dart';
import 'base.view_model.dart';
import 'package:fuodz/translations/forgot_password.i18n.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgotPasswordViewModel extends MyBaseViewModel {
  //the textediting controllers
  TextEditingController phoneTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();
  AuthRequest _authRequest = AuthRequest();
  FirebaseAuth auth = FirebaseAuth.instance;
  CountryCode selectedCountryCode;
  String accountPhoneNumber;
  //
  String firebaseToken;
  String firebaseVerificationId;

  ForgotPasswordViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  countryCodeSelected(CountryCode countryCode) {
    selectedCountryCode = countryCode;
  }

  //verify on the server to see if there is an account associated with the supplied phone number
  processForgotPassword() async {
    accountPhoneNumber = "${selectedCountryCode.dialCode}${phoneTEC.text}";
    // Validate returns true if the form is valid, otherwise false.
    if (formKey.currentState.validate()) {
      //
      setBusy(true);
      final apiResponse =
          await _authRequest.verifyPhoneAccount(accountPhoneNumber);
      if (apiResponse.allGood) {
        //
        final phoneNumber = apiResponse.body["phone"];
        accountPhoneNumber = phoneNumber;
        processFirebaseForgotPassword(phoneNumber);
      } else {
        CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Forgot Password".i18n,
          text: apiResponse.message,
        );
      }
      setBusy(false);
    }
  }

  //initiate the otp sending to provided phone
  processFirebaseForgotPassword(String phoneNumber) async {
    setBusy(true);

    //
    //firebase authentication
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        //
        UserCredential userCredential = await auth.signInWithCredential(
          credential,
        );

        //fetch user id token
        firebaseToken = await userCredential.user.getIdToken();
        firebaseVerificationId = credential.verificationId;

        //
        setBusy(false);
        showNewPasswordEntry();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          viewContext.showToast(msg: "Invalid Phone Number".i18n);
        } else {
          viewContext.showToast(msg: e.message);
        }
        setBusy(false);
      },
      codeSent: (String verificationId, int resendToken) {
        firebaseVerificationId = verificationId;
        showVerificationEntry();
        setBusy(false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //
        // firebaseVerificationId = verificationId;
        // showVerificationEntry();
        // setBusy(false);
      },
    );
  }

  //show a bottomsheet to the user for verification code entry
  void showVerificationEntry() {
    //
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      builder: (context) {
        return AccountVerificationEntry(
          vm: this,
          onSubmit: (smsCode) {
            //
            verifyFirebaseOTP(smsCode);
            viewContext.pop();
          },
        );
      },
    );
  }

  //verify the provided code with the firebase server
  void verifyFirebaseOTP(String smsCode) async {
    //
    setBusyForObject(firebaseVerificationId, true);

    // Sign the user in (or link) with the credential
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: firebaseVerificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential = await auth.signInWithCredential(
        phoneAuthCredential,
      );
      //
      firebaseToken = await userCredential.user.getIdToken();
      showNewPasswordEntry();
    } catch (error) {
      viewContext.showToast(msg: "$error", bgColor: Colors.red);
    }
    //
    setBusyForObject(firebaseVerificationId, false);
  }

  //show a bottomsheet to the user for verification code entry
  showNewPasswordEntry() {
    //
    showModalBottomSheet(
      context: viewContext,
      isScrollControlled: true,
      builder: (context) {
        return NewPasswordEntry(
          vm: this,
          onSubmit: (password) {
            //
            finishChangeAccountPassword();
            viewContext.pop();
          },
        );
      },
    );
  }

  //
  finishChangeAccountPassword() async {
    //

    setBusy(true);
    final apiResponse = await _authRequest.resetPasswordRequest(
      phone: accountPhoneNumber,
      password: passwordTEC.text,
      firebaseToken: firebaseToken,
    );
    setBusy(false);

    CoolAlert.show(
        context: viewContext,
        type: apiResponse.allGood ? CoolAlertType.success : CoolAlertType.error,
        title: "Forgot Password".i18n,
        text: apiResponse.message,
        onConfirmBtnTap: () {
          viewContext.navigator.popUntil((route) => route.isFirst);
        });
  }
}
