import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/order.dart';
import 'package:shop/models/shop_details.dart';
import 'package:shop/utilities/api_calls.dart';
import 'package:shop/widgets/orders_list.dart';

class ApprovedTab extends StatefulWidget {
  List<Order> approvedOrdersList;

  @override
  _ApprovedTabState createState() => _ApprovedTabState();
}

class _ApprovedTabState extends State<ApprovedTab> {
  bool isLoaded = false;

  void getOrders() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    ShopDetails _shopDetails = ShopDetails.fromJson(jsonDecode(_sharedPreferences.getString('shopDetails')));

    var response = await ApiCalls.getRequest(
        ['order'], {'gst': _shopDetails.gst, 'status': 'APPROVED'});
    print("APPROVED RESPONSE");
    print(response);

    List<Order> orders = [];
    List<Map<String, dynamic>> items = [];
    for (var order in response) {
      bool added = false;
      for(var item in items) {
        if(item['id'] == order['orderno']) {
          item['itemId'].add(order['item'].toString());
          item['quantity'].add(1);
          added = true;
          break;
        }
      }
      if(!added) {
        items.add({
          'id': order['orderno'],
          'itemId': [order['item'].toString()],
          'aadharNo': order['person'],
          'quantity': [1],
          'shopId': order['shop']['gst_no'],
          'toLocation': 'Delivery',
          'status': order['status'],
        });
      }
    }

    for (var item in items) {
      orders.add(Order.fromJson(item));
    }

    if(mounted) {
      setState(() {
        isLoaded = true;

        //widget.approvedOrdersList = orders;
        widget.approvedOrdersList = [
          Order.fromJson({
            'itemId': ['121351345', '696956'],
            'shopId': '1234',
            'quantity': [3, 4],
            'aadharNo': '1235-5678-9012',
            'toLocation': 'Andheri',
            'status': 'APPROVED'
          }),
          Order.fromJson({
            'itemId': ['5321', '61314'],
            'shopId': '1234',
            'quantity': [5, 6],
            'aadharNo': '1234-5678-9012',
            'toLocation': 'Chembur',
            'status': 'APPROVED'
          })
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.approvedOrdersList == null || isLoaded == false) {
      isLoaded = false;
      getOrders();
    }
    return isLoaded
        ? SafeArea(
        child: Container(
            child: SingleChildScrollView(
              child: OrdersList(
                  ordersList: widget.approvedOrdersList == null ? [] : widget.approvedOrdersList, status: Status.APPROVED),
            )))
        : Center(
      child: SpinKitCubeGrid(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
