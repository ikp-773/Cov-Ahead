import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/screens/authentication/sign_in.dart';
import 'package:covid_qrcode_bfh/screens/customer/details.dart';
import 'package:covid_qrcode_bfh/screens/merchant/dashboard.dart';
import 'package:covid_qrcode_bfh/screens/merchant/details.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class SignUp extends StatefulWidget {
  final bool isCustomer;
  SignUp({Key key, this.title, this.isCustomer}) : super(key: key);

  final String title;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcf5ff),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    });
                try {
                  UserModel result = await _auth.signInUsingGoogle(
                      isCustomer: widget.isCustomer);

                  if (result == null) {
                    setState(() {
                      error = 'Could not sign you in using google.';
                    });
                  } else if (widget.isCustomer) {
                    Get.offAll(() => DetailsCustomer());
                  } else {
                    Get.offAll(() => DetailsMerchant());
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 23),
                decoration: BoxDecoration(
                  color: Colors.purple[700],
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
                      margin: EdgeInsets.fromLTRB(0, 10, 15, 10),
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
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
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(SignIn(
                      isCustomer: widget.isCustomer,
                    ));
                  },
                  child: Text(
                    'Log in ',
                    style: TextStyle(
                      color: Colors.purple[800],
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 150),
            Text(
              'Create an account',
              style: TextStyle(
                fontFamily: 'ChelaOne',
                color: Colors.black,
                fontSize: 38,
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
                          fontSize: 13,
                        ),
                        decoration:
                            textFieldDecoration.copyWith(labelText: 'Email'),
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
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      decoration:
                          textFieldDecoration.copyWith(labelText: 'Password'),
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
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      decoration: textFieldDecoration.copyWith(
                          labelText: 'Confirm Password'),
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
                        dynamic result = await _auth.signUpUsingEmail(
                            email, password, widget.isCustomer);

                        if (result == null) {
                          setState(() {
                            error = 'Sign up failed using email';
                          });
                        } else if (widget.isCustomer) {
                          Get.off(DetailsCustomer());
                        } else {
                          Get.off(MerchantDashboard());
                        }
                      }
                    },
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                        margin: EdgeInsets.symmetric(horizontal: 23),
                        decoration: BoxDecoration(
                          color: Colors.purple[500],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 50,
                        width: 600,
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
