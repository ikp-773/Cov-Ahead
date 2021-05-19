import 'package:covid_qrcode_bfh/models/customer.dart';
import 'package:covid_qrcode_bfh/models/merchant.dart';
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
  // final AuthServices _auth = AuthServices();

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
          child: Consumer<CustomerModel>(builder: (context, merchant, child) {
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
                            children: [
                              TextFormField(
                                initialValue: merchantData.merchantName,
                                decoration:
                                    InputDecoration(labelText: 'Merchant Name'),
                                validator: (value) => value.isEmpty
                                    ? 'Field Cannot be Blank '
                                    : null,
                                // onFieldSubmitted: (value) {
                                //   setState(() {
                                //     merchantName = value;
                                //   });
                                // },
                                onChanged: (value) {
                                  setState(() {
                                    merchantName = value;
                                  });
                                },
                              ),
                              TextFormField(
                                initialValue: merchantData.shopName ?? '',
                                decoration:
                                    InputDecoration(labelText: 'Shop Name'),
                                validator: (value) => value.isEmpty
                                    ? 'Field Cannot be Blank '
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    shopName = value;
                                  });
                                },
                              ),
                              TextFormField(
                                initialValue: merchantData.mail,
                                readOnly: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration:
                                    InputDecoration(labelText: 'Mail ID'),
                              ),
                              TextFormField(
                                initialValue: merchantData.phoneNum ?? '',
                                keyboardType: TextInputType.phone,
                                decoration:
                                    InputDecoration(labelText: 'Phone Number'),
                                validator: (value) =>
                                    value.isEmpty ? 'Enter your Number ' : null,
                                onChanged: (value) {
                                  setState(() {
                                    phoneNum = value;
                                  });
                                },
                              ),
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
                                decoration:
                                    InputDecoration(labelText: 'Shop Address'),
                              ),
                              TextFormField(
                                initialValue: merchantData.pinCode ?? '',
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(labelText: 'Pincode'),
                                validator: (value) => value.isEmpty
                                    ? 'Enter your proper pincode'
                                    : null,
                                onChanged: (value) {
                                  setState(() {
                                    pinCode = value;
                                  });
                                },
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
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
                                  style: TextStyle(color: Colors.white),
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
                });
          }),
        ),
      ),
    );
  }
}
