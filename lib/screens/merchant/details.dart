import 'package:covid_qrcode_bfh/models/merchant.dart';
import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/screens/customer/constants.dart';
import 'package:covid_qrcode_bfh/screens/merchant/dashboard.dart';
import 'package:covid_qrcode_bfh/services/merchant_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DetailsMerchant extends StatefulWidget {
  DetailsMerchant({Key key}) : super(key: key);

  @override
  _DetailsMerchantState createState() => _DetailsMerchantState();
}

class _DetailsMerchantState extends State<DetailsMerchant> {
  final _formKey = GlobalKey<FormState>();

  String merchantName = '';
  String shopName = '';
  String email = '';
  String phoneNum = '';
  String address = '';
  String pinCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Merchant Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Consumer<UserModel>(
            builder: (context, merchant, child) {
              return StreamBuilder<MerchantData>(
                stream: MerchDatabaseService(uid: merchant?.uid).merchantData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final merchantData = snapshot.data;
                    return Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 12),
                              Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 2),
                              TextFormField(
                                initialValue: merchantData.merchantName,
                                decoration: detailsDecoration.copyWith(
                                    hintText: 'Your Name'),
                                validator: (value) => value.isEmpty
                                    ? 'Field Cannot be Blank '
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    merchantName = value;
                                  });
                                },
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Shop Name',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 2),
                              TextFormField(
                                initialValue: merchantData.shopName ?? '',
                                decoration: detailsDecoration.copyWith(
                                    labelText: 'Shop Name'),
                                validator: (value) => value.isEmpty
                                    ? 'Field Cannot be Blank '
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    shopName = value;
                                  });
                                },
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Mail ID',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 2),
                              TextFormField(
                                initialValue: merchantData.mail,
                                readOnly: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration: detailsDecoration,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Phone Number',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 2),
                              TextFormField(
                                initialValue: merchantData.phoneNum ?? '',
                                keyboardType: TextInputType.phone,
                                decoration: detailsDecoration.copyWith(
                                    labelText: 'Phone Number'),
                                validator: (value) =>
                                    value.isEmpty ? 'Enter your Number ' : null,
                                onChanged: (value) {
                                  setState(() {
                                    phoneNum = value;
                                  });
                                },
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Shop Address',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 2),
                              TextFormField(
                                initialValue: merchantData.address ?? '',
                                minLines: 3,
                                maxLines: 3,
                                validator: (value) => value.isEmpty
                                    ? 'Enter your Address/Locality'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    address = value;
                                  });
                                },
                                decoration: detailsDecoration.copyWith(
                                    hintText: 'Location of your shop'),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Pincode',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 2),
                              TextFormField(
                                initialValue: merchantData.pinCode ?? '',
                                keyboardType: TextInputType.number,
                                decoration: detailsDecoration.copyWith(
                                    labelText: 'Pincode'),
                                validator: (value) => value.isEmpty
                                    ? 'Enter your proper pincode'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    pinCode = value;
                                  });
                                },
                              ),
                              SizedBox(height: 50),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  elevation: 5,
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    await MerchDatabaseService(
                                            uid: merchant.uid)
                                        .updateUserData(
                                      merchantName: (merchantName == '')
                                          ? merchantData.merchantName
                                          : merchantName,
                                      mail: merchantData.mail,
                                      phoneNum: (phoneNum == '')
                                          ? merchantData.phoneNum
                                          : phoneNum,
                                      pinCode: (pinCode == '')
                                          ? merchantData.pinCode
                                          : pinCode,
                                      address: (address == '')
                                          ? merchantData.address
                                          : address,
                                      shopName: (shopName == '')
                                          ? merchantData.shopName
                                          : shopName,
                                    );
                                    Get.to(MerchantDashboard());
                                  }
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    print("No Data Available");
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
