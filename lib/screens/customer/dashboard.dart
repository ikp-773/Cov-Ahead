import 'package:covid_qrcode_bfh/models/customer.dart';
import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/screens/customer/details.dart';
import 'package:covid_qrcode_bfh/screens/customer/qr_scan.dart';
import 'package:covid_qrcode_bfh/screens/merchant_or_customer.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:covid_qrcode_bfh/services/customer_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DashboardCustomer extends StatefulWidget {
  DashboardCustomer({Key key}) : super(key: key);

  @override
  _DashboardCustomerState createState() => _DashboardCustomerState();
}

class _DashboardCustomerState extends State<DashboardCustomer> {
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
            Text(
              'Shops Visited',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
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
                Get.offAll(() => MerchantOrCustomer());
              },
              child: Icon(
                Icons.power_settings_new_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<UserModel>(
        builder: (context, customer, child) {
          // Following condition to prevent accessing uid after logging out
          // Merchant becomes null after logging out, so this is required
          if (customer == null)
            return Container();
          else
            return StreamBuilder<List<PlacesVisited>>(
              stream: DatabaseService(uid: customer.uid).placesVisited,
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                if (snapshot.hasData) {
                  return Center(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ShopsTile(
                          snapshot: snapshot.data[index],
                        );
                      },
                    ),
                  );
                }
                return SizedBox(
                  height: Get.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}

class ShopsTile extends StatelessWidget {
  final snapshot;
  const ShopsTile({@required this.snapshot});

  @override
  Widget build(BuildContext context) {
    String date = snapshot.timestamp.toString().substring(0, 10);
    String time = snapshot.timestamp.toString().substring(11, 23);
    int hour24 = int.parse(time.substring(0, 2));
    int hour12 = hour24 < 13 ? hour24 : hour24 - 12;
    String ampm = hour24 < 12 ? 'AM' : 'PM';
    return Container(
      margin: EdgeInsets.fromLTRB(18, 10, 18, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xfffcf5ff),
        boxShadow: [
          BoxShadow(
            color: Color(0x24000000),
            offset: Offset(0, 0),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      height: 90,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            bottom: 20,
            left: 20,
            child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.purple[200],
                boxShadow: [
                  BoxShadow(
                    color: Color(0x54000000),
                    blurRadius: 3,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  snapshot.storeName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 90,
            child: Text(
              snapshot.storeName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            left: 90,
            top: 40,
            child: Text(
              '${date.substring(8, 10)}-${date.substring(5, 7)}-${date.substring(0, 4)}',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            left: 90,
            bottom: 15,
            child: Text(
              '$hour12 : ${time.substring(3, 5)} $ampm',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
