import 'package:covid_qrcode_bfh/models/merchant.dart';
import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/screens/merchant/details.dart';
import 'package:covid_qrcode_bfh/screens/merchant/qr_generated.dart';
import 'package:covid_qrcode_bfh/screens/merchant_or_customer.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:covid_qrcode_bfh/services/merchant_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MerchantDashboard extends StatefulWidget {
  @override
  _MerchantDashboardState createState() => _MerchantDashboardState();
}

class _MerchantDashboardState extends State<MerchantDashboard> {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, merchant, child) {
        // Following condition to prevent accessing uid after logging out
        // Merchant becomes null after logging out, so this is required
        if (merchant == null)
          return Container();
        else {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Customers',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.settings_rounded),
                    tooltip: 'Edit details',
                    onPressed: () {
                      Get.off(() => DetailsMerchant());
                    }),
                IconButton(
                    icon: Icon(Icons.qr_code),
                    tooltip: 'View QR code',
                    onPressed: () {
                      MerchDatabaseService(uid: merchant.uid)
                          .merchantData
                          .listen((merchData) {
                        if (merchData != null) {
                          Get.off(() => GeneratedQR(merchantData: merchData));
                        }
                      });
                    }),
                IconButton(
                    icon: Icon(Icons.power_settings_new_rounded),
                    tooltip: 'LogOut',
                    onPressed: () {
                      _auth.signOut();

                      Get.offAll(() => MerchantOrCustomer());
                    })
              ],
            ),
            body: StreamBuilder<List<MerchantVisitorLog>>(
              stream: MerchDatabaseService(uid: merchant.uid).visitorsLog,
              builder: (BuildContext context,
                  AsyncSnapshot<List<MerchantVisitorLog>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          MerchDatabaseService(uid: merchant.uid)
                              .merchantData
                              .listen((merchData) {
                            if (merchData != null) {
                              Get.off(
                                  () => GeneratedQR(merchantData: merchData));
                            }
                          });
                        },
                        child: Text(
                          'View QR Code',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return snapshot.data != null
                            ? CustomerTile(
                                snapshot: snapshot.data[index],
                              )
                            : Container();
                      },
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          );
        }
      },
    );
  }
}

class CustomerTile extends StatelessWidget {
  final snapshot;
  const CustomerTile({@required this.snapshot});

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
                  snapshot.customerName[0],
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
              snapshot.customerName,
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
