import 'package:covid_qrcode_bfh/screens/merchant_or_customer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting
            ) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: (MerchantOrCustomer()),
        );
      },
    );
  }
}
