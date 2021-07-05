import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuodz/models/order.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class ScanOrderVerificationDialog extends StatefulWidget {
  ScanOrderVerificationDialog({this.order, this.onValidated, Key key})
      : super(key: key);

  //
  final Order order;
  final Function onValidated;
  @override
  _ScanOrderVerificationDialogState createState() =>
      _ScanOrderVerificationDialogState();
}

class _ScanOrderVerificationDialogState
    extends State<ScanOrderVerificationDialog> {
  //
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        "Verification Code".i18n.text.semiBold.xl.make(),
        //
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
        ).wFull(context).hOneThird(context).py12(),
      ],
    ).p20().pOnly(bottom: context.mq.viewPadding.bottom);
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      print("Result ==> ${result.code}");
      if (widget.order.verificationCode == result.code) {
        controller.stopCamera();
        controller.dispose();
        context.pop();
        widget.onValidated();
      } else {
        print("Invalid code");
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
