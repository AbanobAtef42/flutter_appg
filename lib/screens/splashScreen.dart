import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app8/screens/StartShoppingScreen.dart';
import 'package:flutter_app8/screens/loginScreen.dart';
import 'package:flutter_app8/values/SharedPreferenceClass.dart';
import 'package:flutter_app8/values/myConstants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  static String name = 'splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    SharedPrefs().priceUnit('');
  //  SharedPrefs().exertedPriceUnit('');
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this,);
    animation = Tween(begin: 0.0, end:250.0).animate(controller)
      ..addListener(() {
        setState(() {
// the state that has changed here is the animation object’s value
        });
      });
    controller.forward();

    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                    StartShopping(

                    ))));
  }

  @override
  Widget build(BuildContext context) {
    final String assetName = 'images/full_logo.svg';
    //final String assetName = 'images/arabic2.png';

    SvgPicture svg = new SvgPicture.asset(assetName,);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: animation.value,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),

                child: svg),
          ),

      ]),
    );
  }
}
