import 'package:deflon/provider/app_state.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class RideInfo extends StatefulWidget {
  @override
  _RideInfoState createState() => _RideInfoState();
}

class _RideInfoState extends State<RideInfo> {
  void rebuildMaps(route){

  }
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.7),
          child: Center(
            child: Card(
              color: Colors.deepOrange,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                child: Text('Ride Booked Successfully!', style: TextStyle(color: Colors.white),),
              ),
            )
          ),
        ),
    );
  }
}