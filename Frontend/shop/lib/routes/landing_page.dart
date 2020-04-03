import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/routes/dashboard.dart';
import 'package:shop/routes/login_page.dart';

class LandingPage extends StatefulWidget {
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  _LandingPageState() {
    //Hardcode Login

    SharedPreferences.getInstance().then((_sharedPreferences) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Dashboard(
                  shopDetailsString: jsonEncode({
                'phoneNumber': '1234567890',
                'gst': '1231433463587357',
                'id': '123',
                'location': ['122.21', '121.21'],
                'verificationStatus': true
              }))));
      return;
      //Checks for login
      bool _isLoggedIn = _sharedPreferences.getBool('isLoggedIn');

      //First login
      if (_isLoggedIn == null) {
        _isLoggedIn = false;
        _sharedPreferences.setBool('isLoggedIn', _isLoggedIn);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      }

      //Leads to Dashboard
      if (_isLoggedIn) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Dashboard(
                shopDetailsString:
                    _sharedPreferences.getString('shopDetails'))));
        return;
      } else {
        //Leads to login page
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
