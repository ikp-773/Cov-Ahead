import 'dart:io';

import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/screens/customer/check_qr_code.dart';
import 'package:covid_qrcode_bfh/screens/customer/dashboard.dart';
import 'package:covid_qrcode_bfh/screens/customer/details.dart';
import 'package:covid_qrcode_bfh/screens/merchant_or_customer.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeCustomer extends StatefulWidget {
  HomeCustomer({Key key}) : super(key: key);

  @override
  _HomeCustomerState createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  final AuthServices _auth = AuthServices();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  var user;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'CovAhead',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(DetailsCustomer());
              },
              child: Icon(
                Icons.settings_rounded,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                _auth.signOut();
                Get.off(MerchantOrCustomer());
              },
              child: Icon(
                Icons.power_settings_new_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            child: Center(
              child: Text(
                'Align the QR Code',
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(DashboardCustomer());
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x24000000),
                      offset: Offset(5, 8),
                      blurRadius: 28,
                      spreadRadius: 2,
                    ),
                  ]),
              child: Text(
                'Shops Visited',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.purple,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen(
      (scanData) async {
        setState(() {
          result = scanData;
        });
        print(
            '\n-------------\n\nBarcode Type: ${describeEnum(result.format)}   Data: ${result.code}');
        if (result.code != null) {
          controller.dispose();

          Get.off(CheckQR(
            code: result.code,
            customerUID: user.uid,
          ));
        }
      },
    );
  }
}
