import 'package:flutter/material.dart';
import 'package:shop/models/item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/routes/order_page.dart';

class ItemCard extends StatelessWidget {
  final Function deleteItemFromList;
  final Item item;

  ItemCard({this.item, this.deleteItemFromList});

  void deleteItem() {}

  @override
  Widget build(BuildContext context) {
    /*return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Text(item.getName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteItem(),
            )
          ]),
          Text(item.getDescription),
          Text(item.getPrice.toString()),
          Text(item.getQuantityAvailable.toString()),
        ]));*/
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.only(left: 12, right: 10, top: 10, bottom: 10),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  child: Container(
                child: Text(
                  item.getName,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.fade,
                ),
              )),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteItem(),
              )
            ],
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                item.getDescription,
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
                            item.getQuantityAvailable.toString() +
                                ' items left.',
                            style: TextStyle(
                                fontSize: 13, fontStyle: FontStyle.italic),
                          ),
                          Text('₹' + item.getPrice.toString(),
                              style: TextStyle(fontSize: 13)),
                        ]),
                  ]))
        ]));
  }
}
