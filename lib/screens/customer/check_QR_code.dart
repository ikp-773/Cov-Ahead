import 'dart:async';

import 'package:covid_qrcode_bfh/screens/customer/dashboard.dart';
import 'package:covid_qrcode_bfh/screens/customer/qr_scan.dart';
import 'package:covid_qrcode_bfh/services/merchant_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckQR extends StatefulWidget {
  final String code;
  final String customerUID;
  CheckQR({Key key, this.code, this.customerUID}) : super(key: key);

  @override
  _CheckQRState createState() => _CheckQRState();
}

class _CheckQRState extends State<CheckQR> {
  void navigationPage() {
    Get.off(DashboardCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder(
          future: MerchDatabaseService(uid: widget.code)
              .isMerchantPresent(customerUID: widget.customerUID),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                Timer(Duration(seconds: 5),
                    () => Get.off(() => DashboardCustomer()));
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified,
                      color: Colors.green,
                    ),
                    SizedBox(height: 20),

                    // Add some other success text here
                    Text('Success! You can continue shopping'),
                    SizedBox(height: 20),
                    Text(
                      'You will be now redirected to dashboard',
                      style: TextStyle(fontWeight: FontWeight.w100),
                    )
                  ],
                );
              } else {
                Timer(
                    Duration(seconds: 3), () => Get.off(() => HomeCustomer()));
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 20,
                    ),
                    SizedBox(height: 20),

                    // Add some other success text here
                    Text('Try scanning the QR code again'),
                    SizedBox(height: 20),

                    Text(
                      'You will be redirected to QR code scanner',
                      style: TextStyle(fontWeight: FontWeight.w100),
                    )
                  ],
                );
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
