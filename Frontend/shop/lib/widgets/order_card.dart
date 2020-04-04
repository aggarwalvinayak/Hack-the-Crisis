import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';
import 'package:shop/routes/order_page.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: FlatButton(
            padding: EdgeInsets.all(20),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => OrderPage(order: order))),
            child: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(order.getToLocation,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)))),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                Text('Item',
                    style:
                        TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                Text('Quantity',
                    style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic))
              ]),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: order.getItemId.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(order.getItemId[index], style: TextStyle(fontSize: 15)),
                              Text(order.getQuantity[index].toString(), style: TextStyle(fontSize: 15))
                            ]));
                  })
            ])));
  }
}
