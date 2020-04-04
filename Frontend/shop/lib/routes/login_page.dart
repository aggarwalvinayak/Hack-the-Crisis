import 'package:flutter/material.dart';
import 'package:shop/widgets/login_card.dart';
import 'package:shop/widgets/signup_card.dart';

enum AuthMode { LOGIN, SIGN_UP }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthMode _auth;

  void changeAuth() {
    setState(() {
      if(_auth == AuthMode.LOGIN)
        _auth = AuthMode.SIGN_UP;
      else
        _auth = AuthMode.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child:SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(height: MediaQuery.of(context).size.height / 2,
            color: Theme.of(context).primaryColor,),
            _auth == AuthMode.LOGIN ? LoginCard(changeAuth: changeAuth) : SignupCard(changeAuth: changeAuth),
          ],
        ),
      )
    ));
  }
}
