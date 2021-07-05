import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/views/pages/auth/forgot_password.page.dart';
import 'package:fuodz/views/pages/auth/login.page.dart';
import 'package:fuodz/views/pages/chat/chat.page.dart';
import 'package:fuodz/views/pages/home.page.dart';
import 'package:fuodz/views/pages/notification/notification_details.page.dart';
import 'package:fuodz/views/pages/notification/notifications.page.dart';
import 'package:fuodz/views/pages/onboarding.page.dart';
import 'package:fuodz/views/pages/order/orders_details.page.dart';
import 'package:fuodz/views/pages/product/product_details.page.dart';
import 'package:fuodz/views/pages/profile/change_password.page.dart';
import 'package:fuodz/views/pages/profile/edit_profile.page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.welcomeRoute:
      return MaterialPageRoute(builder: (context) => OnboardingPage());

    case AppRoutes.loginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());

    case AppRoutes.forgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPasswordPage());

    case AppRoutes.homeRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.homeRoute, arguments: Map()),
        builder: (context) => HomePage(),
      );

    //order details page
    case AppRoutes.orderDetailsRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.orderDetailsRoute),
        builder: (context) => OrderDetailsPage(
          order: settings.arguments,
        ),
      );
    case AppRoutes.productDetailsRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.productDetailsRoute),
        builder: (context) => ProductDetailsPage(
          product: settings.arguments,
        ),
      );
    //chat page
    case AppRoutes.chatRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.chatRoute),
        builder: (context) => ChatPage(
          chatEntity: settings.arguments,
        ),
      );

    //
    case AppRoutes.editProfileRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.editProfileRoute),
        builder: (context) => EditProfilePage(),
      );

    //change password
    case AppRoutes.changePasswordRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: AppRoutes.changePasswordRoute),
        builder: (context) => ChangePasswordPage(),
      );

    //profile settings/actions
    case AppRoutes.notificationsRoute:
      return MaterialPageRoute(
        settings:
            RouteSettings(name: AppRoutes.notificationsRoute, arguments: Map()),
        builder: (context) => NotificationsPage(),
      );

    //
    case AppRoutes.notificationDetailsRoute:
      return MaterialPageRoute(
        settings: RouteSettings(
            name: AppRoutes.notificationDetailsRoute, arguments: Map()),
        builder: (context) => NotificationDetailsPage(
          notification: settings.arguments,
        ),
      );

    default:
      return MaterialPageRoute(builder: (context) => OnboardingPage());
  }
}
