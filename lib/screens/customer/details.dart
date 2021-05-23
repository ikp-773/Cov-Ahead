import 'package:covid_qrcode_bfh/models/customer.dart';
import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/screens/customer/constants.dart';
import 'package:covid_qrcode_bfh/services/customer_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class DetailsCustomer extends StatefulWidget {
  DetailsCustomer({Key key}) : super(key: key);

  @override
  _DetailsCustomerState createState() => _DetailsCustomerState();
}

class _DetailsCustomerState extends State<DetailsCustomer> {
  final _formKey = GlobalKey<FormState>();
  // final AuthServices _auth = AuthServices();

  String name = '';
  String email = '';
  String phoneNum = '';
  String address = '';
  String pinCode = '';
  int vaccineStat; //For dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Sign In"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Column(
            children: [
              Consumer<UserModel>(
                builder: (context, customer, child) {
                  return StreamBuilder<CustomerData>(
                      stream: DatabaseService(uid: customer?.uid).customerData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final customerData = snapshot.data;
                          print("Data Present");
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  initialValue: customerData.name,
                                  decoration: detailsDecoration.copyWith(
                                      labelText: 'Name'),
                                  validator: (value) => value.isEmpty
                                      ? 'Field Cannot be Blank '
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                ),
                                TextFormField(
                                  initialValue: customerData.mail,
                                  readOnly: true,
                                  decoration: detailsDecoration.copyWith(
                                      labelText: 'Mail ID'),
                                  onChanged: (value) {
                                    setState(() {
                                      email = value;
                                    });
                                  },
                                ),
                                TextFormField(
                                  initialValue: customerData.phoneNum ?? '',
                                  keyboardType: TextInputType.phone,
                                  decoration: detailsDecoration.copyWith(
                                      labelText: 'Phone Number'),
                                  validator: (value) => value.isEmpty
                                      ? 'Enter your Number '
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      phoneNum = value;
                                    });
                                  },
                                ),
                                TextFormField(
                                  initialValue: customerData.address ?? '',
                                  minLines: 3,
                                  maxLines: 3,
                                  decoration: detailsDecoration.copyWith(
                                      labelText: 'Address'),
                                  validator: (value) => value.isEmpty
                                      ? 'Enter your Address/Locality'
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      address = value;
                                    });
                                  },
                                ),
                                TextFormField(
                                  initialValue: customerData.pinCode ?? '',
                                  keyboardType: TextInputType.number,
                                  decoration: detailsDecoration.copyWith(
                                      labelText: 'Pin Code'),
                                  validator: (value) => value.length != 6
                                      ? 'Enter your proper pincode '
                                      : null,
                                  onChanged: (value) {
                                    setState(() {
                                      pinCode = value;
                                    });
                                  },
                                ),

                                // Vaccine status dropdown, needs improvement
                                DropdownButtonFormField(
                                  decoration: detailsDecoration.copyWith(
                                      labelText: 'Vacination Status'),
                                  value:
                                      vaccineStat ?? customerData.vaccineStatus,
                                  onChanged: (val) {
                                    setState(() {
                                      vaccineStat = val;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('Not vaccinated'),
                                      value: 0,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Taken First Dose'),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text('Fully vaccinated'),
                                      value: 2,
                                    ),
                                  ],
                                ),

                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      await DatabaseService(uid: customer.uid)
                                          .updateUserData(
                                        name: (name == '')
                                            ? customerData.name
                                            : name,
                                        mail: customerData.mail,
                                        phoneNum: (phoneNum == '')
                                            ? customerData.phoneNum
                                            : phoneNum,
                                        pinCode: (pinCode == '')
                                            ? customerData.pinCode
                                            : pinCode,
                                        address: (address == '')
                                            ? customerData.address
                                            : address,
                                        vaccineStatus: vaccineStat ??
                                            customerData.vaccineStatus,
                                      );
                                      Get.off(HomeCustomer());
                                    }
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          print("No Data Available");
                          return Center(child: CircularProgressIndicator());
                        }
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
