import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/routes/dashboard.dart';
import 'package:shop/utilities/api_calls.dart';

class LoginCard extends StatefulWidget {
  final Function changeAuth;

  LoginCard({this.changeAuth});

  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController phoneNumberController, passwordController;

  _LoginCardState() {
    phoneNumberController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  void login(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

    phoneNumberController.text;
    passwordController.text;

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitCubeGrid(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }));

    var response = await ApiCalls.postRequest(['loginapi'],
        {'phoneno': phoneNumberController.text, 'password': passwordController.text, 'type': 2});
    print("RESPONSE:");
    print(response);

    if(response[0] is String) {
      Navigator.pop(context);
      Scaffold.of(context).showSnackBar(SnackBar(content:Text('Incorrect phone number or password')));
      return;
    }

    String _shopDetailsString = jsonEncode({
      'phoneNumber': response['phoneno'],
      'gst': response['gst_no'],
      'id': '123',
      'shopName':response['shopname'],
      'category' : response['categ'],
      'firstName': response['firstname'],
      'lastName' : response['lastname'],
      'verificationStatus': true
    });

    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setBool('isLoggedIn', true);
    _sharedPreferences.setString('shopDetails', _shopDetailsString);

    Navigator.pop(context);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Dashboard(
                  shopDetailsString: _shopDetailsString,
                )));

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Dashboard(
        shopDetailsString: _shopDetailsString,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          /*if (val.length == 10) return null;
                          return 'Please enter a valid phone number';*/
                        },
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          labelText: "Phone number",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (val) {
                          /*
                          if (val.length < 8) return 'Password too short';
                          return null;*/
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Container(),
                          ),
                          FlatButton(
                            child: Text("Login"),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            padding: EdgeInsets.only(
                                left: 38, right: 38, top: 15, bottom: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () => login(context),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () => widget.changeAuth(),
              textColor: Colors.black87,
              child: Text("Create Account"),
            )
          ],
        )
      ],
    );
  }
}
