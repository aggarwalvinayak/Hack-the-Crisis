import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'globals.dart' as globals;
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';


Future<List<ListItem>> fetchList() async {
  final response = await Dio().get('http://amazekart.tech:8080/permissions/');
  print(response.data);
  return parseList(response.data);
}

List<ListItem> parseList(dynamic respBody) {
  return respBody.map<ListItem>((json) => ListItem.fromJson(json)).toList();
}

class ListItem {
  final int permID;
  final String areaassoc;
  final String status;
  final String date;
  final String permReason;
  final String starttime;
  final String endtime;

  //ListItem({this.permID, this.personName, this.phoneNumber, this.permReason, this.personLocationLat, this.personLocationLong});

  ListItem.fromJson(Map<String, dynamic> json)
      :
        permID = json['id'],
        areaassoc = json['areaassoc'],
        status = json['status'],
        permReason = json['permreason'],
        date = json['date'],
        starttime = json['starttime'],
        endtime = json['endtime']
  ;
}


class PermPage extends StatefulWidget {
  @override
  _PermPageState createState() => _PermPageState();
}

class _PermPageState extends State<PermPage> {
  @override
  Widget build(BuildContext context) {
    if (globals.authMode == globals.AuthMode.LOGGED) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Approve Permissions"),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddPermission())),
          child: Icon(Icons.add),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
        ),
        body: Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: FutureBuilder<List<ListItem>>(
              future: fetchList(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? PermList(perms: snapshot.data)
                    : Center(child: CircularProgressIndicator(),);
              },
            )
        ),
      );
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
}


class AddPermission extends StatefulWidget {

  AddPermission();

  _AddPermissionState createState() => _AddPermissionState();
}

class _AddPermissionState extends State<AddPermission> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController phoneController,
      areaAssocController,
      permReasonController;

  _AddPermissionState() {
    phoneController = new TextEditingController();
    areaAssocController = new TextEditingController();
    permReasonController = new TextEditingController();
  }

  void addItem(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitCubeGrid(
            color: Theme
                .of(context)
                .primaryColor,
          ),
        ),
      );
    }));


    var response = await Dio().post(
        'http://amazekart.tech:8080/permissions/', data: FormData.fromMap({
      'phone': phoneController.text,
      'permreason': permReasonController.text,
      'areaassoc': areaAssocController.text,
      'status': 'PENDING',
      'date': '04-Apr-2020',
      'starttime': '14:00',
      'endtime': '15:00',
      'lat': 45.521563,
      'lon': -122.677433
    }));
    print(response);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: SingleChildScrollView(
            child: Stack(
                children: <Widget>[
                  Container(height: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                    color: Theme
                        .of(context)
                        .primaryColor,), Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery
                            .of(context)
                            .size
                            .height / 20),
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
                                      "Add Item",
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
                                    controller: phoneController,
                                    validator: (val) {
                                      if (val.isEmpty) return 'Mandatory field';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Phone number"),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: areaAssocController,
                                    decoration: InputDecoration(
                                        labelText: "Area associated"),
                                    validator: (val) {
                                      if (val.isEmpty) return 'Mandatory field';
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: permReasonController,
                                    validator: (val) {
                                      if (val.isEmpty) return 'Mandatory field';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Permission reason"),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  /*TextFormField(
                                    controller: quantityController,
                                    keyboardType: TextInputType.number,
                                    validator: (val) {
                                      if (val.isNotEmpty) return null;
                                      return 'Please enter a valid quantity';
                                    },
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(labelText: "Quantity available"),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  */
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(),
                                      ),
                                      FlatButton(
                                        child: Text("Add Permission"),
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        textColor: Colors.white,
                                        padding: EdgeInsets.only(
                                            left: 38,
                                            right: 38,
                                            top: 15,
                                            bottom: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5)),
                                        onPressed: () => addItem(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                ]))));
  }
}

class PermList extends StatelessWidget {
  final List<ListItem> perms;

  PermList({Key key, this.perms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: perms.length,
      itemBuilder: (context, index) {
        return Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .cardColor,
                borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.only(left: 12, right: 10, top: 10, bottom: 10),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                      child: Container(
                        child: Text(
                          perms[index].areaassoc,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      )),
                  IconButton(
                    icon: Icon(Icons.thumb_up, color: Colors.lightGreen,),
                    onPressed: () {},
                  )
                ],
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    perms[index].permReason,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 5, left: 2),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                perms[index].status,
                                style: TextStyle(
                                    fontSize: 13, fontStyle: FontStyle.italic),
                              ),
                              Text(
                                perms[index].date,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              Text(perms[index].starttime + ' to ' +
                                  perms[index].endtime,
                                  style: TextStyle(fontSize: 13)),
                            ]),
                      ]))
            ]));
      },
    );
  }
}

