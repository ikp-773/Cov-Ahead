import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customer/qr_scan.dart';
import 'merchant/dashboard.dart';
import 'merchant_or_customer.dart';

class Welcome extends StatelessWidget {
  // Loading customer or merchant data
  Future<bool> isCust() async {
    bool isCustomer = true;
    SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    if (_sharedPref.containsKey('isCustomer')) {
      isCustomer = _sharedPref.getBool('isCustomer');
    }
    return isCustomer;
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    return FutureBuilder(
        future: isCust(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            //Loading till connection is established
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (user == null) {
            return MerchantOrCustomer();
          }
          //USER is present
          if (user.uid == '') {
            // Stream is being initialized
            return CircularProgressIndicator();
          } else {
            // Conditional for customer or merchant
            if (snapshot.data) {
              return HomeCustomer();
            } else {
              return MerchantDashboard();
            }
          }
        });
  }
}
