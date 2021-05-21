import 'package:covid_qrcode_bfh/screens/customer/dashboard.dart';
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
    Get.off(DashboarCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder(
          future: MerchDatabaseService(uid: widget.code)
              .isMerchantPresent(customerUID: widget.customerUID),
          // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print('------------>>>>' + snapshot.toString());

            if (snapshot.connectionState == ConnectionState.waiting)
              {return CircularProgressIndicator();}

            return Text(snapshot.data.toString());
          },
        ),
      ),
    );
  }
}
