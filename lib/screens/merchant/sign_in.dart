import 'package:covid_qrcode_bfh/screens/customer/home.dart';
import 'package:covid_qrcode_bfh/screens/merchant/dashboard.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants.dart';

class SignInMerchant extends StatefulWidget {
  @override
  _SignInMerchantState createState() => _SignInMerchantState();
}

class _SignInMerchantState extends State<SignInMerchant> {
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
        height: 130,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Or Login with',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  dynamic result = await _auth.signInUsingGoogle();

                  if (result == null) {
                    setState(() {
                      error = 'Could not Sign In';
                    });
                  } else {
                    Get.to(() => MerchantDashboard());
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 23),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
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
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Icon(
                  Icons.close_rounded,
                  color: Color(0xff151522),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 14.5),
              child: Text(
                'Welcome Back',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
                    child: Text(
                      'Email Address',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      decoration: textFieldDecoration,
                      validator: (value) =>
                          value.isEmpty ? 'Enter a valid email' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      decoration:
                          textFieldDecoration.copyWith(hintText: 'Password'),
                      validator: (value) =>
                          value.length < 6 ? 'Incorrect password' : null,
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
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {});
                        dynamic result =
                            await _auth.signInUsingMail(email, password);
                        Get.off(HomeCustomer());
                        if (result == null) {
                          setState(() {
                            error = 'Could not Sign In with the Credentials';
                          });
                        }
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
                        'Login',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forget Password? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Reset here ',
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
