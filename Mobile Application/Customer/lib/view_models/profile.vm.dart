import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/view_models/payment.view_model.dart';
import 'package:fuodz/views/pages/splash.page.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/user.dart';
import 'package:fuodz/requests/auth.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/widgets/cards/language_selector.view.dart';
import 'package:package_info/package_info.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:share/share.dart';
import 'package:fuodz/translations/dialogs.i18n.dart';

class ProfileViewModel extends PaymentViewModel {
  //
  String appVersionInfo = "";
  bool authenticated = false;
  User currentUser;

  //
  AuthRequest _authRequest = AuthRequest();

  ProfileViewModel(BuildContext context) {
    this.viewContext = context;
  }

  void initialise() async {
    //
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
    String versionCode = packageInfo.buildNumber;
    appVersionInfo = "$versionName($versionCode)";
    authenticated = await AuthServices.authenticated();
    if (authenticated) {
      currentUser = await AuthServices.getCurrentUser(force: true);
    }
    notifyListeners();
  }

  /**
   * Edit Profile
   */

  openEditProfile() async {
    final result = await viewContext.navigator.pushNamed(
      AppRoutes.editProfileRoute,
    );

    if (result != null && result) {
      initialise();
    }
  }

  /**
   * Change Password
   */

  openChangePassword() async {
    viewContext.navigator.pushNamed(
      AppRoutes.changePasswordRoute,
    );
  }

  //
  openWallet() {
    viewContext.navigator.pushNamed(
      AppRoutes.walletRoute,
    );
  }

  /**
   * Delivery addresses
   */
  openDeliveryAddresses() {
    viewContext.navigator.pushNamed(
      AppRoutes.deliveryAddressesRoute,
    );
  }

  //
  openFavourites() {
    viewContext.navigator.pushNamed(
      AppRoutes.favouritesRoute,
    );
  }

  /**
   * Logout
   */
  logoutPressed() async {
    CoolAlert.show(
      context: viewContext,
      type: CoolAlertType.confirm,
      title: "Logout".i18n,
      text: "Are you sure you want to logout?".i18n,
      onConfirmBtnTap: () {
        viewContext.pop();
        processLogout();
      },
    );
  }

  void processLogout() async {
    //
    CoolAlert.show(
      context: viewContext,
      type: CoolAlertType.loading,
      title: "Logout".i18n,
      text: "Logging out Please wait...".i18n,
      barrierDismissible: false,
    );

    //
    final apiResponse = await _authRequest.logoutRequest();

    //
    viewContext.pop();

    if (!apiResponse.allGood) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Logout",
        text: apiResponse.message,
      );
    } else {
      //
      await AuthServices.logout();
      viewContext.navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SplashPage()),
        (route) => false,
      );
    }
  }

  openNotification() async {
    viewContext.navigator.pushNamed(
      AppRoutes.notificationsRoute,
    );
  }

  /**
   * App Rating & Review
   */
  openReviewApp() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    } else {
      inAppReview.openStoreListing(appStoreId: AppStrings.appStoreId);
    }
  }

  //
  openPrivacyPolicy() async {
    final url = Api.privacyPolicy;
    if (await canLaunch(url)) {
      // await launch(url);
      openWebpageLink(url);
    } else {
      viewContext.showToast(
        msg: 'Could not launch $url',
      );
    }
  }

  //
  changeLanguage() async {
    showModalBottomSheet(
      context: viewContext,
      builder: (context) {
        return AppLanguageSelector(
          onSelected: (code) async {
            viewContext.pop();
            I18n.of(viewContext).locale = Locale(code ?? "en");
            await AuthServices.setLocale(I18n.language);
          },
        );
      },
    );
  }

  openLogin() async {
    await viewContext.navigator.pushNamed(
      AppRoutes.loginRoute,
    );
    //
    initialise();
  }

  void shareReferralCode() {
    Share.share(
      "%s is inviting you to join %s via this referral code: %s".i18n.fill(
        [
          currentUser.name,
          AppStrings.appName,
          currentUser.code,
        ],
      ),
    );
  }
}
