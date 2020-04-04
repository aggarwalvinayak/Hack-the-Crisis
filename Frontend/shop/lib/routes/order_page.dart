import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utilities/api_calls.dart';

class OrderPage extends StatefulWidget {
  Order order;

  OrderPage({this.order});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order')),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.order.getToLocation,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SpinKitPulse(
                        color: widget.order.getStatus == Status.PENDING
                            ? Colors.red
                            : (widget.order.getStatus == Status.APPROVED
                                ? Colors.yellow
                                : Colors.green))
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Item'),
                    Text('Quantity')
                  ]),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.order.getItemId.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.order.getItemId[index]),
                              Text(widget.order.getQuantity[index].toString())
                            ]));
                  })
            ],

          )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: widget.order.getStatus == Status.PENDING
                ? Colors.green
                : Colors.grey,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            //change status of the order
            //ApiCalls.postRequest(pathList, parameters);
            setState(() {
              widget.order.setStatus(Status.APPROVED);
            });
          },
          child: Text(
            widget.order.getStatus == Status.PENDING
                ? 'Approve'
                : widget.order.getStatus == Status.APPROVED
                    ? 'Approved'
                    : 'Completed',
            style: TextStyle(
                color: widget.order.getStatus == Status.PENDING
                    ? Colors.white
                    : Colors.grey[900]),
          ),
        ),
      ),
    );
  }
}
