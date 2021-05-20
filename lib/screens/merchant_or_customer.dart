import 'package:covid_qrcode_bfh/screens/customer/sign_up.dart';
import 'package:covid_qrcode_bfh/screens/merchant/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MerchantOrCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences _sharedPref =
                      await SharedPreferences.getInstance();
                  _sharedPref.setBool('isCustomer', false);
                  Get.to(() => SignUpMerchant());
                },
                child: Text('Contine as Merchant'),
              ),
            ),
            Text('OR'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async{
                  SharedPreferences _sharedPref =
                      await SharedPreferences.getInstance();
                  _sharedPref.setBool('isCustomer', true);
                  Get.to(SignUpCustomer());
                },
                child: Text('Contine as Customer'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
