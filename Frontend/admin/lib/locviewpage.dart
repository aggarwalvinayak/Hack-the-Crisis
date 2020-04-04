import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'globals.dart' as globals;

class LocView extends StatefulWidget {
  @override
  _LocViewState createState() => _LocViewState();
}

class _LocViewState extends State<LocView> {
  GoogleMapController mapCtrl;

  final Set<Marker> _markers = {
    Marker(
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(45.017870, -122.278350),
      markerId: MarkerId('')
    ),
    Marker(
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(45.517870, -122.878350),
        markerId: MarkerId('')
    ),
    Marker(
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(45.317870, -122.478350),
        markerId: MarkerId('')
    ),
    Marker(
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(45.617870, -122.478350),
        markerId: MarkerId('')
    )
  };

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapCtrl = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (globals.authMode == globals.AuthMode.LOGGED) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Affected Location View"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  globals.authMode = globals.AuthMode.LOGIN;
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("LOGOUT"),
            )
          ],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
        ),
      );
    } else {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text("Update News"),
          ),
          body: new Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 8,
                      child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                              "Please go back and log in to access this page",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              )))))
            ],
          ));
    }
  }
}
