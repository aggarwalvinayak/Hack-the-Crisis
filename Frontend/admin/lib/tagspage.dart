import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'globals.dart' as globals;

enum STATE { SEARCH, FOUND }

class TagsPage extends StatefulWidget {
  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {

  final _phnoCnt = TextEditingController();
  STATE state = STATE.SEARCH;
  Map parsed;

  int _radioValue;
  int _result;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      _result = value;
    });
}

  @override
  Widget build(BuildContext context) {
    if (globals.authMode == globals.AuthMode.LOGGED) {

      if (state == STATE.SEARCH) {
        return new Scaffold(
        appBar: new AppBar(
          title: new Text("Update Tags"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  globals.authMode = globals.AuthMode.LOGIN;
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("LOGOUT"),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 30, bottom: 15),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Enter the details of the person",
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
                      decoration: InputDecoration(
                        labelText: "Aadhar Number", hasFloatingPlaceholder: true, ),
                      controller: _phnoCnt,
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
                          child: Text("Search"),
                          color: Colors.red,
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: _performSearch,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      } else {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Update Tags"),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    globals.authMode = globals.AuthMode.LOGIN;
                  });
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text("LOGOUT"),
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30, bottom: 15),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Person Info",
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
                          Text("Person Name: " + parsed['user']['firstname'] + " " + parsed['user']['lastname'], textAlign: TextAlign.left,),
                          Text("\nPhone Number: " + parsed['user']['phoneno'], textAlign: TextAlign.left),
                          Text("\nAadhar Number: " + parsed['aadharno'], textAlign: TextAlign.left),
                          Text("\nLast Location: Lat: " + parsed['lat'].toString() + " Long: " + parsed['lon'].toString(), textAlign: TextAlign.left),
                          Text("\nTag: 1 - RED, 2 - YELLOW, 3 - GREEN\n\t\t\t\tTag Value: " + parsed['tag'].toString(), textAlign: TextAlign.left),
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
                                child: Text("Go back to Search"),
                                color: Colors.red,
                                textColor: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 38, right: 38, top: 15, bottom: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () => {setState(() {
                                  state = STATE.SEARCH;
                                })},
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Change Tag",
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
                          Text("Tag: 1 - RED, 2 - YELLOW, 3 - GREEN\n", textAlign: TextAlign.left),
                          Text("Change tag to:"),
                          Row(
                            children: <Widget>[
                              Radio(value: 1, groupValue: _radioValue, onChanged: _handleRadioValueChange,),
                              Text("RED"),
                              Radio(value: 2, groupValue: _radioValue, onChanged: _handleRadioValueChange, ),
                              Text("YELLOW"),
                              Radio(value: 3, groupValue: _radioValue, onChanged: _handleRadioValueChange, ),
                              Text("GREEN"),
                            ],
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
                                child: Text("Change Tag"),
                                color: Colors.red,
                                textColor: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 38, right: 38, top: 15, bottom: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: _performChange,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
        );
      }
    } else {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text("Update News"),
          ),
          body: new Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 8,
                      child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                              "Please go back and log in to access this page",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              )
                          )
                      )
                  )
              )
            ],
          )
      );
    }
  }

  void _performSearch() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitCubeGrid(
            color:  Color(0xFF083663),
          ),
        ),
      );
    }));
    Response response;
    Dio dio = new Dio();
    response = await dio.get("http://amazekart.tech:8080/loginapi/", queryParameters: {"aadhar": _phnoCnt.text});

    parsed = response.data[0];
    print(parsed.toString());

    setState(() {
      state = STATE.FOUND;
    });
    Navigator.pop(context);
  }

  void _performChange() async {
    var dio = Dio();
    FormData formdata = new FormData.fromMap({
      'aadhar' : parsed['aadharno'],
      'new_tag' : _result
    });
    Response resp;

    String url = "http://amazekart.tech:8080/updatetag/";
    resp = await dio.post(url, data: formdata);
    print(resp.data);

  }

}


