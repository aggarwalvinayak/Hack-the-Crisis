import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/item.dart';
import 'package:shop/models/shop_details.dart';
import 'package:shop/routes/add_item_page.dart';
import 'package:shop/utilities/api_calls.dart';
import 'package:shop/widgets/items_list.dart';

class ItemsPage extends StatefulWidget {
  List<Item> itemsList;

  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  bool isLoaded = false;

  void getItems() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    ShopDetails _shopDetails = ShopDetails.fromJson(
        jsonDecode(_sharedPreferences.getString('shopDetails')));

    var response = await ApiCalls.getRequest(
        ['item'], {'gst': int.parse(_shopDetails.gst)});
    print("Item RESPONSE");
    print(response);

    List<Item> items = [];
    for (var item in response) {
      items.add(Item(
          name: item['itemname'],
          description: item['description'],
          price: item['price'],
          quantityAvailable: int.parse(item['quantity_max']),
          shopId: item['shop'].toString()));
    }

    setState(() {
      isLoaded = true;
      widget.itemsList = items;
    });
  }

  void _addItem(Item item) {
    setState(() {
      widget.itemsList.add(item);
    });
  }

  void _deleteItem() {}

  @override
  Widget build(BuildContext context) {
    if (widget.itemsList == null) {
      isLoaded = false;
      getItems();
    }
    return isLoaded
        ? Scaffold(
            appBar: AppBar(
              title: Text('Items'),
              centerTitle: true,
            ),
            body: SafeArea(
                child: Container(
                    child: SingleChildScrollView(
              child: ItemsList(
                  itemsList: widget.itemsList, deleteItemFromList: _deleteItem),
            ))),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddItem(addItemToList: _addItem))),
              child: Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          )
        : Center(
            child: SpinKitCubeGrid(
              color: Theme.of(context).primaryColor,
            ),
          );
  }
}
