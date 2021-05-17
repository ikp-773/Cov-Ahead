import 'package:covid_qrcode_bfh/models/merchant.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class GeneratedQR extends StatelessWidget {
  final MerchantData merchantData;
  GeneratedQR({this.merchantData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrettyQr(
          size: 300,
          data: merchantData.uid,
          roundEdges: true,
          typeNumber: 3,
        ),
      ),
    );
  }
}
