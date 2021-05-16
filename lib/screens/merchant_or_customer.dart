import 'package:flutter/material.dart';

class MerchantOrCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('Welcome'),
          ElevatedButton(
            onPressed: () {
              print('Clicked!');
            },
            child: Text('Contine as Merchant'),
          ),
          Text('OR'),
          ElevatedButton(
            onPressed: () {},
            child: Text('Contine as Customer'),
          )
        ],
      ),
    );
  }
}
