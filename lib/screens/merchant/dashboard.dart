import 'package:covid_qrcode_bfh/models/merchant.dart';
import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/services/merchant_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MerchantDashboard extends StatefulWidget {
  @override
  _MerchantDashboardState createState() => _MerchantDashboardState();
}

class _MerchantDashboardState extends State<MerchantDashboard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(builder: (context, merchant, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Merchant Dashboard'),
        ),
        body: StreamBuilder<List<MerchantVisitorLog>>(
          stream: MerchDatabaseService(uid: merchant.uid).visitorsLog,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print('Inside builder: ' + snapshot.data.toString());
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].customerName),
                      leading: Text(snapshot.data[index].timestamp.toString()),
                    );
                  },
                ),
              );
            }
            print('NO data');
            return CircularProgressIndicator();
          },
        ),
      );
    });
  }
}
