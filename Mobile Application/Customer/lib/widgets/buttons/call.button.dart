import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/constants/app_colors.dart';

class CallButton extends StatelessWidget {
  const CallButton(this.vendor, {Key key}) : super(key: key);

  final Vendor vendor;
  @override
  Widget build(BuildContext context) {
    return Icon(
      FlutterIcons.phone_ant,
      size: 24,
      color: Colors.white,
    ).p8().box.color(AppColor.primaryColor).roundedFull.make().onInkTap((){
        launch("tel://${vendor.phone}");
    });
  }
}
