import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';
import 'package:shop/models/shop_details.dart';
import 'package:shop/widgets/orders_list.dart';

class PendingTab extends StatefulWidget {
  List<Order> pendingOrdersList;

  @override
  _PendingTabState createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {

  void getOrders() {
    setState(() {

    widget.pendingOrdersList = [
      Order.fromJson({
        'itemId': ['12345', '23456'],
        'shopId': Provider.of<ShopDetails>(context).id,
        'quantity': [1, 2],
        'aadharNo': '1234-5678-9012',
        'toLocation': 'Kurla',
        'status': 'PENDING'
      }),
      Order.fromJson({
        'itemId': ['121351345', '696956'],
        'shopId': Provider.of<ShopDetails>(context).id,
        'quantity': [3, 4],
        'aadharNo': '1235-5678-9012',
        'toLocation': 'Andheri',
        'status': 'PENDING'
      }),
      Order.fromJson({
        'itemId': ['5321', '61314'],
        'shopId': Provider.of<ShopDetails>(context).id,
        'quantity': [5, 6],
        'aadharNo': '1234-5678-9012',
        'toLocation': 'Chembur',
        'status': 'PENDING'
      })
    ];
    });
  }

  @override
  Widget build(BuildContext context) {
    getOrders();
    return SafeArea(child:
      Container(
        child: SingleChildScrollView(
          child: OrdersList(ordersList: widget.pendingOrdersList, status:Status.PENDING),
        )
      )
    );
  }
}
