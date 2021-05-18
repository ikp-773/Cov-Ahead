import 'package:covid_qrcode_bfh/models/customer.dart';
import 'package:covid_qrcode_bfh/services/database.dart';
import 'package:flutter/material.dart';

class MerchantDashboard extends StatefulWidget {
  @override
  _MerchantDashboardState createState() => _MerchantDashboardState();
}

class _MerchantDashboardState extends State<MerchantDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Merchant Dashboard'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: DatabaseService().customerData,
          // initialData: initialData ,
          builder:
              (BuildContext context, AsyncSnapshot<CustomerData> snapshot) {
            if (snapshot.hasData)
              return Container(
                child: Text(snapshot.data.mail),
              );

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
