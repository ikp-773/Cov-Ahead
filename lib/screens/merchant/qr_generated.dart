import 'package:covid_qrcode_bfh/models/merchant.dart';
import 'package:covid_qrcode_bfh/screens/merchant/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class GeneratedQR extends StatelessWidget {
  final MerchantData merchantData;
  GeneratedQR({this.merchantData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.off(() => MerchantDashboard());
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                  margin: EdgeInsets.fromLTRB(23, 0, 23, 24),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 50,
                  width: 600,
                  child: Text(
                    'Proceed to Dashboard',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Text(
              //   'Take a printout and keep it posted at your shop entry',
              //   style: TextStyle(fontWeight: FontWeight.w100),
              // )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Hello ' + merchantData.merchantName + ',',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'QR code for ' + merchantData.shopName + ':',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              PrettyQr(
                size: 200,
                data: merchantData.uid,
                roundEdges: true,
                typeNumber: 3,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Text(
                    'Take a printout and keep it posted at your shop entry'),
              ),
              // Text('Take a printout and keep it posted at your shop entry'),
            ],
          ),
        ),
      ),
    );
  }
}
