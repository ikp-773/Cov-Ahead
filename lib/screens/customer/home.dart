import 'package:flutter/material.dart';

class HomeCustomer extends StatefulWidget {
  HomeCustomer({Key key}) : super(key: key);

  @override
  _HomeCustomerState createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Home'),
      ),
      body: Container(
        child: Center(
          child: Icon(
            Icons.power_settings_new_rounded,
            size: 40,
          ),
        ),
      ),
    );
  }
}
