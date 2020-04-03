import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';

class PendingTab extends StatefulWidget {
  @override
  _PendingTabState createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(child:Text(Status.PENDING.toString())));
  }
}
