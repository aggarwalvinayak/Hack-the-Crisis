import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/shop_details.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Consumer<ShopDetails>(
            builder: (context, shopDetails, child) {
              return Text(shopDetails.phoneNumber, style: TextStyle(
                color: Colors.white
              ));
            },
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        ListTile(
          title: Text('Manage Products'),
        ),
      ],
    ));
  }
}
