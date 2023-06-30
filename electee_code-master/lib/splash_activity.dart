import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'HomePage.dart';
import 'dart:async';

class SplashSceen extends StatefulWidget {
  @override
  _SplashSceenState createState() => _SplashSceenState();
}

class _SplashSceenState extends State<SplashSceen>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController textAnimation;

  @override
  void initState() {
    super.initState();

    // for icon
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      upperBound: 300.0,
      // upperBound: 150.0,
    );

    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });

    // for Text
    textAnimation = AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
        upperBound: 100,
        lowerBound: 30);
    textAnimation.reverse();
    textAnimation.addListener(() {
      setState(() {});
    });

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // height: 500,
                  height: controller.value,
                  child: Image(
                    image: AssetImage("assets/playstore.png"),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                  child: Divider(
                    height: 2.0,
                    color: kMainColor,
                  ),
                ),
                Hero(
                  tag: "logo",
                  child: Text(
                    "i-Vote",
                    style: TextStyle(
                        color: kMainColor,
                        fontFamily: 'Dark',
                        fontSize: textAnimation.value,
                        letterSpacing: 2.0),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "With ❤ by",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    fontFamily: kFontFamily,
                  ),
                ),
                Text(
                  " SIDDHI PATEL, \nDHRUV SHAH, \nRIYA SHAH",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kMainColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    letterSpacing: 2.5,
                    fontFamily: kFontFamily,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
