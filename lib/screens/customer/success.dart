import 'dart:async';

import 'package:covid_qrcode_bfh/screens/customer/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessQR extends StatefulWidget {
  SuccessQR({Key key}) : super(key: key);

  @override
  _SuccessQRState createState() => _SuccessQRState();
}

class _SuccessQRState extends State<SuccessQR> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Get.off(DashboarCustomer());
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(child: Text('QR Scanned')),
      ),
    );
  }
}
