import 'package:admin/locviewpage.dart';
import 'package:admin/newspage.dart';
import 'package:admin/permpage.dart';
import 'package:admin/tagspage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.red),
      home: new HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    globals.authMode == globals.AuthMode.LOGIN
      ? debugPrint("Login")
      : debugPrint("Signup");
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sahayak - Admin"),
        elevation: 5.0,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text("Govt Off 1"), accountEmail: new Text("xyz@mygov.in")),
            new ListTile(
              title: new Text("Update News"),
              onTap: () => {
                //Navigator.of(context).pop(),
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new NewsPage())),
              }
            ),
            new ListTile(
              title: new Text("Update Tags"),
              onTap: () => {
                //Navigator.of(context).pop(),
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new TagsPage())),
              }
            ),
            new ListTile(
              title: new Text("Affected Location View"),
              onTap: () => {
                //Navigator.of(context).pop(),
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new LocView())),
              }
            ),
            new ListTile(
              title: new Text("Update Permissions"),
              onTap: () => {
                //Navigator.of(context).pop(),
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new PermPage())),
              }
            ),
            new ListTile(
                title: new Text("Logout"),
                onTap: () => {
                  globals.authMode = globals.AuthMode.LOGIN,
                }
            )
          ],
        )
      ),
      body: new Container(
        child: new LoginPage()
        )
      );
  }
}

class LoginPage extends StatefulWidget {

  _LoginPageState newLoginCard = new _LoginPageState();
  @override
  _LoginPageState createState() => newLoginCard;
}

class _LoginPageState extends State<LoginPage> {

  double screenHeight;
  final _phnoCnt = TextEditingController();
  final _pswdCnt = TextEditingController();
  final _fnameCnt = TextEditingController();
  final _lnameCnt = TextEditingController();
  final _distCnt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: globals.authMode == globals.AuthMode.LOGIN
        ? loginCard(context)
        : globals.authMode == globals.AuthMode.SIGNUP
          ? signupCard(context)
            : loggedinCard(context)
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Container(
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
                    decoration: InputDecoration(
                        labelText: "Phone Number", hasFloatingPlaceholder: true, ),
                    controller: _phnoCnt,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password", hasFloatingPlaceholder: true),
                    controller: _pswdCnt,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text("Forgot Password ?"),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      FlatButton(
                        child: Text("Login"),
                        color: Colors.red,
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: _performLogin,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
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
              onPressed: () {
                setState(() {
                  globals.authMode = globals.AuthMode.SIGNUP;
                });
              },
              textColor: Colors.black87,
              child: Text("Create Account"),
            )
          ],
        )
      ],
    );
  }

  Widget signupCard(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
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
                    decoration: InputDecoration(
                        labelText: "Phone Number", hasFloatingPlaceholder: true),
                    controller: _phnoCnt,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password", hasFloatingPlaceholder: true),
                    controller: _pswdCnt,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "First Name", hasFloatingPlaceholder: true),
                    controller: _fnameCnt,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Last Name", hasFloatingPlaceholder: true),
                    controller: _lnameCnt,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "District Name", hasFloatingPlaceholder: true),
                    controller: _distCnt,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password must be at least 8 characters and include a special character and number",
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
                        color: Colors.red,
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: _performRegister,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
              onPressed: () {
                setState(() {
                  globals.authMode = globals.AuthMode.LOGIN;
                });
              },
              textColor: Colors.black87,
              child: Text("Login"),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FlatButton(
            child: Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget loggedinCard(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 30),
        child: Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child:  Text(
            "You are logged in, drag drawer on the left for options",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          ),
        )
    );
  }

  void _performLogin() async {
    String phno = _phnoCnt.text;
    String pswd = _pswdCnt.text;

    var dio = Dio();

    FormData formdata = new FormData.fromMap({
      "phoneno":phno,
      "password":pswd,
      "type":3
    });
    Response resp;

    String url = "http://amazekart.tech:8080/loginapi/";
    resp = await dio.post(url, data: formdata);
    print(resp.data);


    if (resp.data != '[F]') {
      setState(() {
        globals.authMode = globals.AuthMode.LOGGED;
      });
    } else {
      setState(() {
        globals.authMode = globals.AuthMode.LOGIN;
      });
    }
  }

  void _performRegister() async {
    String phno = _phnoCnt.text;
    String pswd = _pswdCnt.text;
    String fname = _fnameCnt.text;
    String lname = _lnameCnt.text;
    String dist = _distCnt.text;

    var dio = Dio();

    FormData formdata = new FormData.fromMap({
      "phoneno": phno,
      "password": pswd,
      "type": 3,
      "firstname": fname,
      "lastname": lname,
      "district": dist
    });

    Response resp;

    String url = "http://amazekart.tech:8080/registerapi/";
    resp = await dio.post(url, data: formdata);
    print(resp.data);

    setState(() {
      globals.authMode = globals.AuthMode.LOGIN;
    });

  }
}



