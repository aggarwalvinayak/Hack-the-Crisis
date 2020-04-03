import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';

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
            onPressed: () {},
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: order.itemId.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(order.itemId[index]),
                      Text(order.quantity[index].toString())
                    ],
                  );
                })));
  }
}
