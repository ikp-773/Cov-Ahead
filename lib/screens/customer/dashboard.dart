import 'package:covid_qrcode_bfh/models/customer.dart';
import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/screens/customer/details.dart';
import 'package:covid_qrcode_bfh/screens/customer/home.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:covid_qrcode_bfh/services/customer_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DashboarCustomer extends StatefulWidget {
  DashboarCustomer({Key key}) : super(key: key);

  @override
  _DashboarCustomerState createState() => _DashboarCustomerState();
}

class _DashboarCustomerState extends State<DashboarCustomer> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(builder: (context, customer, child) {
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
                },
                child: Icon(
                  Icons.power_settings_new_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: StreamBuilder<List<PlacesVisited>>(
          stream: DatabaseService(uid: customer.uid).placesVisited,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print('------------>>>>' + snapshot.toString());

            if (snapshot.hasData) {
              print('------------>>>>' + snapshot.toString());
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var shopList = snapshot.data;
                    return ListTile(
                      title: Text('Store:${shopList[index].storeName}'),
                      leading: Text('Time:${shopList[index].timestamp}'),
                    );
                  },
                ),
              );
            }
            print('NO data');
            return CircularProgressIndicator(
              backgroundColor: Colors.green,
            );
          },
        ),
      );
    });
  }
}
