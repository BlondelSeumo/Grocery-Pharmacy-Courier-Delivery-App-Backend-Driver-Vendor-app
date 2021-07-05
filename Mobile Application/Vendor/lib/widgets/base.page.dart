import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class BasePage extends StatefulWidget {
  final bool showAppBar;
  final bool showLeadingAction;
  final bool showCart;
  final Function onBackPressed;
  final String title;
  final Widget body;
  final Widget bottomSheet;
  final Widget bottomNavigationBar;
  final Widget fab;
  final bool isLoading;

  BasePage({
    this.showAppBar = false,
    this.showLeadingAction = false,
    this.showCart = false,
    this.onBackPressed,
    this.title = "",
    this.body,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.fab,
    this.isLoading = false,
    Key key,
  }) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          I18n.language == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: widget.showAppBar
            ? AppBar(
                automaticallyImplyLeading: widget.showLeadingAction,
                leading: widget.showLeadingAction
                    ? IconButton(
                        icon: Icon(
                          FlutterIcons.arrow_left_fea,
                        ),
                        onPressed: widget.onBackPressed ??
                            () => Navigator.pop(context),
                      )
                    : null,
                title: Text(
                  widget.title,
                ),
              )
            : null,
        body: VStack(
          [
            //
            widget.isLoading
                ? LinearProgressIndicator()
                : UiSpacer.emptySpace(),

            //
            widget.body.expand(),
          ],
        ),
        bottomSheet: widget.bottomSheet,
        bottomNavigationBar: widget.bottomNavigationBar,
        floatingActionButton: widget.fab,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
