import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  final _topicCnt = TextEditingController();
  final _bodyCnt = TextEditingController();
  final _distCnt = TextEditingController();
  final _linkCnt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (globals.authMode == globals.AuthMode.LOGGED) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Update News"),
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
                        "News/Notification Update",
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
                        labelText: "District", hasFloatingPlaceholder: true, ),
                      controller: _distCnt,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Subject/Topic/Headline", hasFloatingPlaceholder: true, ),
                      controller: _topicCnt,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Content",
                        hasFloatingPlaceholder: true,
                      ),
                      controller: _bodyCnt,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Link", hasFloatingPlaceholder: true, ),
                      controller: _linkCnt,
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
                          child: Text("Post"),
                          color: Colors.red,
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: _performPost,
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

  void _performPost() async {
    var dio = Dio();

    FormData formdata = new FormData.fromMap({
      "district": _distCnt.text,
      "title":_topicCnt.text,
      "description":_bodyCnt.text,
      "link": _linkCnt
    });
    Response resp;

    String url = "http://amazekart.tech:8080/news/";
    resp = await dio.post(url, data: formdata);
    print(resp.data);

    if(resp.data == "Succeess") {
      showDialog(context: context, child:
        new SimpleDialog(
          title: new Text("Successfully posted", textAlign: TextAlign.center,),
          contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.all(10.0),
          children: <Widget>[
            new FlatButton(onPressed: () => {Navigator.pop(context)}, child: Text("OK"), textColor: Colors.white, color: Colors.red,)
          ],
        )
      );
    }

  }
}

