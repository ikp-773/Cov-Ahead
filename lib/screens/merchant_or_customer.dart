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
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(100, 100, 30, 30),
            ),
            Text(
              'Welcome ',
              style: TextStyle(
                fontFamily: 'ChelaOne',
                fontSize: 45,
                color: Color(0xffc675e6),
              ),
            ),
            SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.purple.shade300;
                        return Colors.purple.shade600;
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () async {
                  SharedPreferences _sharedPref =
                      await SharedPreferences.getInstance();
                  _sharedPref.setBool('isCustomer', false);
                  Get.to(() => SignUpMerchant());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Continue as Merchant',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'SourceSansPro',
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'OR',
              style: TextStyle(color: Colors.purple.shade700),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.purple.shade300;
                        return Colors.purple.shade600;
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () async {
                  SharedPreferences _sharedPref =
                      await SharedPreferences.getInstance();
                  _sharedPref.setBool('isCustomer', true);
                  Get.to(() => SignUpCustomer());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Continue as Customer',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'SourceSansPro',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//https://wallpaperaccess.com/full/885189.png
