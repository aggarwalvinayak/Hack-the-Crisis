import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';
import 'package:shop/widgets/order_card.dart';

class OrdersList extends StatelessWidget {
  final List<Order> ordersList;
  final Status status;

  OrdersList({this.ordersList, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ordersList.isEmpty
          ?
          Text(
            status == Status.PENDING ? 'No pending orders' : (status == Status.APPROVED ? 'No approved orders' : 'No completed orders'),
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
          )
          : ListView.builder(
          itemCount: ordersList.length,
          itemBuilder: (context, index) {
            return OrderCard(order:ordersList[index]);
          }),
    );
  }
}
