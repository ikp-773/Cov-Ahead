import 'package:covid_qrcode_bfh/screens/customer/details.dart';
import 'package:covid_qrcode_bfh/screens/customer/home.dart';
import 'package:covid_qrcode_bfh/screens/merchant_or_customer.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboarCustomer extends StatefulWidget {
  DashboarCustomer({Key key}) : super(key: key);

  @override
  _DashboarCustomerState createState() => _DashboarCustomerState();
}

class _DashboarCustomerState extends State<DashboarCustomer> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          Get.off(HomeCustomer());
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text('Customer Home'),
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
      body: Center(
        child: Container(
          child: Text('Show List of Shop Visited'),
        ),
      ),
    );
  }
}
