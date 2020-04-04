import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/order.dart';
import 'package:shop/models/shop_details.dart';
import 'package:shop/utilities/api_calls.dart';
import 'package:shop/widgets/orders_list.dart';

class PendingTab extends StatefulWidget {
  List<Order> pendingOrdersList;

  PendingTab() {
    /*pendingOrdersList = [
      Order.fromJson({
        'id':'1',
        'itemId': ['12345', '23456'],
        'shopId': '1234',
        'quantity': [1, 2],
        'aadharNo': '1234-5678-9012',
        'toLocation': 'Kurla',
        'status': 'PENDING'
      }),
      Order.fromJson({
        'id':'2',
        'itemId': ['121351345', '696956'],
        'shopId': '1234',
        'quantity': [3, 4],
        'aadharNo': '1235-5678-9012',
        'toLocation': 'Andheri',
        'status': 'PENDING'
      }),
      Order.fromJson({
        'id':'3',
        'itemId': ['5321', '61314'],
        'shopId': '1234',
        'quantity': [5, 6],
        'aadharNo': '1234-5678-9012',
        'toLocation': 'Chembur',
        'status': 'PENDING'
      })
    ];*/
  }

  @override
  _PendingTabState createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  bool isLoaded = false;


  void getOrders() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    ShopDetails _shopDetails = ShopDetails.fromJson(
        jsonDecode(_sharedPreferences.getString('shopDetails')));

    var response = await ApiCalls.getRequest(
        ['order'], {'gst': _shopDetails.gst, 'status': 'PENDING'});
    print("PENDING RESPONSE");
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
          'status': order['status']
        });
      }
    }

    for (var item in items) {
      orders.add(Order.fromJson(item));
    }

    if (mounted) {
      setState(() {
        isLoaded = true;

        //widget.pendingOrdersList = orders;
        widget.pendingOrdersList = [
          Order.fromJson({
            'id':'1',
            'itemId': ['12345', '23456'],
            'shopId': _shopDetails.id,
            'quantity': [1, 2],
            'aadharNo': '1234-5678-9012',
            'toLocation': 'Worli',
            'status': 'PENDING'
          }),
          Order.fromJson({
            'id':'2',
            'itemId': ['121351345', '696956'],
            'shopId': _shopDetails.id,
            'quantity': [3, 4],
            'aadharNo': '1235-5678-9012',
            'toLocation': 'Colaba',
            'status': 'PENDING'
          }),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /*
    return SafeArea(
        child: Container(
            child: SingleChildScrollView(
              child: OrdersList(
                  ordersList: widget.pendingOrdersList == null
                      ? []
                      : widget.pendingOrdersList,
                  status: Status.PENDING),
            )));*/
    if (widget.pendingOrdersList == null || isLoaded == false) {
      isLoaded = false;
      getOrders();
    }
    return isLoaded
        ? SafeArea(
            child: Container(
                child: SingleChildScrollView(
            child: OrdersList(
                ordersList: widget.pendingOrdersList == null
                    ? []
                    : widget.pendingOrdersList,
                status: Status.PENDING),
          )))
        : Center(
            child: SpinKitCubeGrid(
              color: Theme.of(context).primaryColor,
            ),
          );
  }
}
