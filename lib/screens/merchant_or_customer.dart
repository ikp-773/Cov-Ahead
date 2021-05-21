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
                image: NetworkImage(
                    'https://c4.wallpaperflare.com/wallpaper/683/498/374/blurred-colorful-vertical-portrait-display-wallpaper-preview.jpg'),
                fit: BoxFit.fill)),
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
                  fontFamily: 'SourceSansPro',
                  fontSize: 32,
                  color: Colors.purple),
            ),
            SizedBox(
              height: 200.0,
              width: 150.0,
              child: Divider(
                color: Colors.teal.shade100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.purple.shade400;
                        return Colors.purple.shade700;
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
                          return Colors.purple.shade400;
                        return Colors.purple.shade700;
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
