// import 'dart:async';
import 'package:deflon/provider/app_state.dart';
import 'package:deflon/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:deflon/widgets/bottom_select.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _mapStyle;
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/maps/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    GoogleMapController mapController;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerMenu(),
      body: Column(
        children: <Widget>[
          appState.initialPosition == null ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.73,
              child: Center(child: CircularProgressIndicator()),
            ) : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.73,
              child:GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      appState.initialPosition.latitude, 
                      appState.initialPosition.longitude),
                    zoom: 11.5
                  ),
                  myLocationButtonEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                    mapController.setMapStyle(_mapStyle);
                  },
                )),
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  spreadRadius: 2.0
                )]),
            child: Column(
              children: <Widget>[
                BottomSelect(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
