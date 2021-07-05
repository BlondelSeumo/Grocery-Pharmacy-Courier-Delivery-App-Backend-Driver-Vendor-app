import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomWebviewPage extends StatelessWidget {
  const CustomWebviewPage({
    Key key,
    this.selectedUrl,
  }) : super(key: key);

  final String selectedUrl;
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: selectedUrl,
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(
            FlutterIcons.arrow_left_fea,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      withZoom: true,
      withJavascript: true,
      withLocalStorage: true,
      withLocalUrl: true,
      initialChild: BusyIndicator(
        color: AppColor.primaryColor,
      ).centered(),
    );
  }
}
