import 'package:covid_qrcode_bfh/screens/customer/home.dart';
import 'package:covid_qrcode_bfh/screens/customer/sign_in.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants.dart';

class SignUpCustomer extends StatefulWidget {
  SignUpCustomer({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpCustomerState createState() => _SignUpCustomerState();
}

class _SignUpCustomerState extends State<SignUpCustomer> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                dynamic result = await _auth.signInUsingGmail();
                Get.off(HomeCustomer());

                if (result == null) {
                  setState(() {
                    error = 'Could not Sign you in.';
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 23),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 50,
                width: 600,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: Image.asset(
                        'assets/icons/google.png',
                        height: 15.4,
                      ),
                    ),
                    Container(
                      width: .5,
                      height: 60,
                      margin: EdgeInsets.fromLTRB(0, 10, 35, 10),
                      color: Color(0x40ffffff),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(SignInCustomer());
                  },
                  child: Text(
                    'log in ',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 100),
          Text(
            'Create an account',
            style: TextStyle(
              color: Color(0xff633820),
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 44, 25, 19),
                  child: TextFormField(
                      style: TextStyle(
                        color: Color(0xff633820),
                        fontSize: 13,
                      ),
                      decoration: textFieldDecoration,
                      validator: (value) =>
                          value.isEmpty ? 'Enter a valid email' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      }),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 19),
                  child: TextFormField(
                    style: TextStyle(
                      color: Color(0xff633820),
                      fontSize: 13,
                    ),
                    decoration:
                        textFieldDecoration.copyWith(hintText: 'Password'),
                    validator: (value) =>
                        value.length < 6 ? 'Minimum 6 characters' : null,
                    obscureText: true,
                    onChanged: (value) {
                      setState(
                        () {
                          password = value;
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 0, 25, 19),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                    decoration: textFieldDecoration.copyWith(
                        hintText: 'Confirm Password'),
                    validator: (value) =>
                        value != password ? 'Passwords doesn\'t match' : null,
                    obscureText: true,
                    onChanged: (value) {
                      setState(
                        () {},
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {});
                      dynamic result =
                          await _auth.signUpUsingEmail(email, password);
                      Get.off(HomeCustomer());

                      if (result == null) {
                        // loading = false;
                        setState(() {});
                      }
                    }
                  },
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                      margin: EdgeInsets.symmetric(horizontal: 23),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 50,
                      width: 600,
                      child: Text(
                        'Get started',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            error,
            style: TextStyle(
              color: Colors.red,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
