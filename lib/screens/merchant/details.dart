import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:flutter/material.dart';

class EditDetailsMerchant extends StatefulWidget {
  EditDetailsMerchant({Key key}) : super(key: key);

  @override
  _EditDetailsMerchantState createState() => _EditDetailsMerchantState();
}

class _EditDetailsMerchantState extends State<EditDetailsMerchant> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

  String name = '';
  String email = '';
  String phoneNum = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Merchant Details"),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (_formKey.currentState.validate()) {
            setState(() {});
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
          margin: EdgeInsets.fromLTRB(23, 0, 23, 24),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5),
          ),
          height: 50,
          width: 600,
          child: Text(
            'Go to Dashboard',
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Merchant Name'),
                      validator: (value) =>
                          value.isEmpty ? 'Field Cannot be Blank ' : null,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Shop Name'),
                      validator: (value) =>
                          value.isEmpty ? 'Field Cannot be Blank ' : null,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Mail ID'),
                      validator: (value) =>
                          value.isEmpty ? 'Field Cannot be Blank ' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter your Number ' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    TextFormField(
                      minLines: 3,
                      maxLines: 3,
                      decoration: InputDecoration(labelText: 'Shop Address'),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Pincode'),
                      validator: (value) =>
                          value.isEmpty ? 'Field Cannot be Blank ' : null,
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
