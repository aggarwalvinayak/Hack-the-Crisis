import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/routes/landing_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _navigatorKey = GlobalKey<NavigatorState>();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.red,
        statusBarIconBrightness: Brightness.light
    ));
    return MaterialApp(
      key: _navigatorKey,
      title: 'Shop',
      theme: ThemeData(
        canvasColor: Color.fromRGBO(225, 235, 245, 1),
        primarySwatch: Colors.red,
      ),
      home: LandingPage(),
    );
  }
}