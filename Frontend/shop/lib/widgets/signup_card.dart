import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/routes/dashboard.dart';
import 'package:shop/utilities/api_calls.dart';

class SignupCard extends StatefulWidget {
  final Function changeAuth;

  SignupCard({this.changeAuth});

  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {

  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _category;
  TextEditingController firstNameController,
      lastNameController,
      shopNameController,
      gstController,
      phoneNumberController,
      passwordController;

  _SignupCardState(){
    firstNameController = new TextEditingController();
    lastNameController = new TextEditingController();
    shopNameController = new TextEditingController();
    gstController = new TextEditingController();
    phoneNumberController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  void register(BuildContext context) async {
    if(!_formKey.currentState.validate()) return;

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitCubeGrid(
            color:  Theme.of(context).primaryColor,
          ),
        ),
      );
    }));

    var response = await ApiCalls.postRequest(['registerapi'], {
    "phoneno":phoneNumberController.text,"firstname":firstNameController.text,'lastname':lastNameController.text,
      "shopname":shopNameController.text,"gst":gstController.text,"cat":_category, 'password':passwordController.text, 'lat': 1,
      'lon': 2
    });
    print(response);

    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool('isLoggedIn', true);
    String _shopDetailsString = jsonEncode({
      'phoneNumber': phoneNumberController.text,
      'gst': gstController.text,
      'id': response[0],
      'location': ['1', '2'],
      'verificationStatus': true
    });
    _sharedPreferences.setString('shopDetails', _shopDetailsString);

    Navigator.pop(context);


    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard( shopDetailsString: _shopDetailsString,)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
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
                        "Create Account",
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
                      controller: firstNameController,
                      validator: (val) {
                        if (val.isEmpty) return 'Mandatory field';
                        return null;
                      },
                      decoration: InputDecoration(labelText: "First Name"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: lastNameController,
                      validator: (val) {
                        if (val.isEmpty) return 'Mandatory field';
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Last Name"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: shopNameController,
                      validator: (val) {
                        if (val.isEmpty) return 'Mandatory field';
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Shop Name"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: gstController,
                      validator: (val) {
                        if (val.isEmpty) return 'Mandatory field';
                        return null;
                      },
                      decoration: InputDecoration(labelText: "GST Number"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: Colors.white,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(labelText: "Category"),
                        items: ['Medicine', 'Food'].map((e) {
                          return new DropdownMenuItem<String>(
                            value: e,
                            child: new Text(e),
                          );
                        }).toList(),
                        onChanged: (val) {
                          _category = val;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val.length == 10) return null;
                        return 'Please enter a valid phone number';
                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(labelText: "Phone number"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (val) {
                        if (val.length < 8) return 'Password too short';
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Password"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Password must be at least 8 characters",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(),
                        ),
                        FlatButton(
                          child: Text("Sign Up"),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () => register(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Text(
          "Current location will be your shop location",
          style: TextStyle(color: Colors.grey),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Already have an account?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () => widget.changeAuth(),
              textColor: Colors.black87,
              child: Text("Login"),
            )
          ],
        ),
      ],
    );
  }
}
