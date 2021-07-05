import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/cart_page_action.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class BasePage extends StatefulWidget {
  final bool showAppBar;
  final bool showLeadingAction;
  final Function onBackPressed;
  final bool showCart;
  final String title;
  final List<Widget> actions;
  final Widget body;
  final Widget bottomSheet;
  final Widget bottomNavigationBar;
  final Widget fab;
  final bool isLoading;

  BasePage({
    this.showAppBar = false,
    this.showLeadingAction = false,
    this.onBackPressed,
    this.showCart = false,
    this.title = "",
    this.actions,
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
                          color: Colors.white,
                        ),
                        onPressed: widget.onBackPressed != null
                            ? widget.onBackPressed
                            : () => Navigator.pop(context),
                      )
                    : null,
                title: widget.title.text.white.make(),
                actions: widget.actions ??
                    [
                      widget.showCart
                          ? PageCartAction()
                          : UiSpacer.emptySpace(),
                    ],
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
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        floatingActionButton: widget.fab,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
