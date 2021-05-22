import 'dart:async';

import 'package:covid_qrcode_bfh/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Get.off(() => Welcome());
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 180.0),
          child: Image.asset('assets/images/splashScreen.png'),
        ),
      ),
    );
  }
}
