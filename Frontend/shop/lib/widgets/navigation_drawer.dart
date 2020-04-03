import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/shop_details.dart';
import 'package:shop/routes/login_page.dart';
import 'package:shop/routes/products_page.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Consumer<ShopDetails>(
            builder: (context, shopDetails, child) {
              return Text('Welcome!\n' + shopDetails.phoneNumber,
                  style: TextStyle(color: Colors.white));
            },
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
        ),
        ListTile(
          leading: Icon(Icons.description),
          title: Text('Manage Products'),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductsPage(),
          )),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () => SharedPreferences.getInstance().then((_sharedPreferences) {
            _sharedPreferences.setBool('isLoggedIn', false);
            _sharedPreferences.setString('shopDetails', '');
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()));
          })
          ,
        ),
      ],
    ));
  }
}
