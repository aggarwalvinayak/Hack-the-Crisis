import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/item.dart';
import 'package:shop/routes/dashboard.dart';
import 'package:shop/utilities/api_calls.dart';

class AddItem extends StatefulWidget {
  final Function addItemToList;

  AddItem({this.addItemToList});

  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController nameController,
      descriptionController,
      quantityController,
      priceController;

  _AddItemState() {
    nameController = new TextEditingController();
    descriptionController = new TextEditingController();
    quantityController = new TextEditingController();
    priceController = new TextEditingController();
  }

  void addItem(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

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


    SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();

    widget.addItemToList(Item(name: nameController.text, description: descriptionController.text,shopId: jsonDecode(_sharedPreferences.getString('shopDetails'))['gst'].toString(),
    quantityAvailable: int.parse(quantityController.text), price: int.parse(priceController.text)));

    var response = await ApiCalls.postRequest([
      'item'
    ], {
      'name':nameController.text,
      'price': int.parse(priceController.text),
      'quant': int.parse(quantityController.text),
      'desc': descriptionController.text,
      'gst':jsonDecode(_sharedPreferences.getString('shopDetails'))['gst']
    });
    print(response);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(child:SingleChildScrollView(
    child: Stack(
    children: <Widget>[
    Container(height: MediaQuery.of(context).size.height / 2,
    color: Theme.of(context).primaryColor,), Column(
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
                      controller: nameController,
                      validator: (val) {
                        if (val.isEmpty) return 'Mandatory field';
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Item Name"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(labelText: "Item description"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val.isNotEmpty) return null;
                        return 'Please enter a valid price';
                      },
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(labelText: "Price of one item"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
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
                          child: Text("Add Item"),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          padding: EdgeInsets.only(
                              left: 38, right: 38, top: 15, bottom: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
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
    )]))));
  }
}
