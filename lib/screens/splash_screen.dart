import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
      image: new AssetImage("assets/images/front.jpg"),
      fit: BoxFit.fill,
    )));
  }
}
