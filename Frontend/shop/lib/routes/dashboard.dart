import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/order.dart';
import 'package:shop/models/shop_details.dart';
import 'package:shop/widgets/navigation_drawer.dart';
import 'package:shop/tabs/dashboard/pending.dart';

class Dashboard extends StatefulWidget {
  final String shopDetailsString;

  Dashboard({this.shopDetailsString});

  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController _tabController;
  int _selectedIndex;

  _DashboardState() {
    _selectedIndex = 0;
  }

  //Initialize tab controller
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(_setSelectedIndex);
  }

  void _setSelectedIndex() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ShopDetails>(
        create: (_) =>
            ShopDetails.fromJson(jsonDecode(widget.shopDetailsString)),
        child: Scaffold(
          drawer: NavigationDrawer(),
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              PendingTab(),
              Container(child: Text(Status.APPROVED.toString())),
              Container(child: Text(Status.COMPLETED.toString())),
            ],
          ),
          bottomNavigationBar: Card(
            margin: EdgeInsets.all(0),
            elevation: 10,
            child: Container(
              child: TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).iconTheme.color,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Theme.of(context).textSelectionColor,
                tabs: [
                  Tab(
                    icon: Icon(Icons.pause),
                    child: Text(
                      'Pending',
                      overflow: TextOverflow.fade,
                      textScaleFactor: 0.8,
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.play_arrow),
                    child: Text(
                      'Approved',
                      overflow: TextOverflow.fade,
                      textScaleFactor: 0.8,
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.check),
                    child: Text(
                      'Completed',
                      overflow: TextOverflow.fade,
                      textScaleFactor: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
