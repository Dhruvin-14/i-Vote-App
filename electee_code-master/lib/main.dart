import 'package:flutter/material.dart';
import 'splash_activity.dart';

void main() {
  runApp(MyApp());
//  FirebaseAdMob.instance.initialize(appId: "com.scupe.electionzz");
}

class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "i-Vote",
      theme: ThemeData(canvasColor: Colors.transparent),
      home: SplashSceen(),
    );
  }
}
