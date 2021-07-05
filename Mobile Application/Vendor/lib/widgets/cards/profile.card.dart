import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/view_models/profile.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/menu_item.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/profile.i18n.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(this.model, {Key key}) : super(key: key);

  final ProfileViewModel model;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //profile card
        (model.isBusy || model.currentUser == null)
            ? BusyIndicator().centered().p20()
            : HStack(
                [
                  //
                  CachedNetworkImage(
                    imageUrl: model.currentUser.photo,
                    progressIndicatorBuilder: (context, imageUrl, progress) {
                      return BusyIndicator();
                    },
                    errorWidget: (context, imageUrl, progress) {
                      return Image.asset(
                        AppImages.user,
                      );
                    },
                  ).wh(Vx.dp64, Vx.dp64).box.roundedFull.make(),

                  //
                  VStack(
                    [
                      //name
                      model.currentUser.name.text.xl.semiBold.make(),
                      //email
                      model.currentUser.email.text.light.make(),
                    ],
                  ).px20().expand(),

                  //
                ],
              ).p12(),

        //
        MenuItem(
          title: "Edit Profile".i18n,
          onPressed: model.openEditProfile,
          topDivider: true,
        ),
        //change password
        MenuItem(
          title: "Change Password".i18n,
          onPressed: model.openChangePassword,
          topDivider: true,
        ),
        //
        MenuItem(
          child: "Logout".i18n.text.red500.make(),
          onPressed: model.logoutPressed,
          divider: false,
          suffix: Icon(
            FlutterIcons.logout_ant,
            size: 16,
          ),
        ),
      ],
    )
        .wFull(context)
        .box
        .border(color: Theme.of(context).cardColor)
        .color(Theme.of(context).cardColor)
        .shadow
        .roundedSM
        .make();
  }
}
