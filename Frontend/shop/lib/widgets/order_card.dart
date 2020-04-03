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
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderPage(order: order))),
            child: Column(children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child:Text(order.getToLocation, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: order.getItemId.length,
                  itemBuilder: (context, index) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(order.getItemId[index]),
                          Text(order.getQuantity[index].toString())
                        ]);
                  })
            ])));
  }
}
