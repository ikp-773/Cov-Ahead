import 'package:covid_qrcode_bfh/models/user.dart';
import 'package:covid_qrcode_bfh/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Right now using CustomerModel for both customer and merch
    // Since only instance var is UID which is available for both
    return StreamProvider<UserModel>.value(
      value: AuthServices().user,
      //Giving initial data of stream as an empty UserModel instead of null
      // to avoid confusion in splashscreen FutureBuilder
      initialData: UserModel(uid: ''),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
