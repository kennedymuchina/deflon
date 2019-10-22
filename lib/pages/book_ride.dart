import 'package:deflon/models/places.dart';
import 'package:deflon/pages/ride-info.dart';
// import 'package:deflon/pages/ride-info.dart';
// import 'package:deflon/pages/map_select.dart';
import 'package:deflon/provider/app_state.dart';
import 'package:deflon/provider/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:deflon/services/credentials.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// import 'dart:math' as math;

class BookRide extends StatefulWidget {
  @override
  _BookRideState createState() => _BookRideState();
}

class _BookRideState extends State<BookRide> {
  // String _heading;
  final _key = GlobalKey<ScaffoldState>();
  List _suggestion;
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();

  bool showSuggestions;

  List<Place> _placeList = [
  Place("Owashika Road", 'Nairobi, Kenya'),
  Place("Owashika Road", 'Nairobi, Kenya'),
  Place("Owashika Road", 'Nairobi, Kenya'),
  Place("Owashika Road", 'Nairobi, Kenya'),
  ];

  List<Destination> _destinationList = [
  Destination("Owashika Road", 'Nairobi, Kenya'),
  Destination("Owashika Road", 'Nairobi, Kenya'),
  Destination("Owashika Road", 'Nairobi, Kenya'),
  Destination("Owashika Road", 'Nairobi, Kenya'),
  ];

  @override
  void initState() {
    super.initState();
    showSuggestions = false;
    // _heading = "Suggestions";
  }

  void getLocationResults(String input) async{
    if(input.isEmpty){
      setState(() {
      // _heading = "Suggestions";
      });
      return;
    }
    
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';


    String request = '$baseURL?input=$input&location=-1.2987826, 36.760992&radius=50000&key=$placesApi';
    Response response = await Dio().get(request);
    final preditions = response.data['predictions'];

    List<Place> _displayResults = [];

    for (var i=0; i<preditions.length; i++){
      String name = preditions[i]['structured_formatting']['main_text'];
      String location = preditions[i]['structured_formatting']['secondary_text'];
      _displayResults.add(Place(name, location));
    }

    setState(() {
    //  _heading = "Results";
     _suggestion = _displayResults;
    });
  }

  void getDestinationResults(String input) async{
    if(input.isEmpty || input.length<2){
      setState(() {
        // _heading = "Suggestions";
      });
      return;
    }

    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    String request = '$baseURL?input=$input&location=-1.2987826,36.760992&radius=50000&key=$placesApi';
    Response response = await Dio().get(request);
    final preditions = response.data['predictions'];

    List<Destination> _displayDestinations = [];

    for (var i=0; i<preditions.length; i++){
      String name = preditions[i]['structured_formatting']['main_text'];
      String location = preditions[i]['structured_formatting']['secondary_text'];
      _displayDestinations.add(Destination(name, location));
    }

    setState(() {
      // _heading = "Results";
      _suggestion = _displayDestinations;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final username = Provider.of<UserProvider>(context);
    appState.user = username;
    return SafeArea(
      top: true,
      child: Scaffold(
        key:  _key,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black,),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text('Select Destination', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: MapsFullScreen(),
            ),
            (appState.polyLines.isNotEmpty) ? StackedCards() : SizedBox(height: 0),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: 0,
              left: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                  focusNode: nodeOne,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    hintText: "Enter pick-up point",
                                    border:
                                        OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                   controller: appState.departureController,
                                  onTap: ()  {
                                    showSuggestions=true;
                                    _suggestion = _placeList;
                                  },
                                  onChanged: (text) {
                                    getLocationResults(text);
                                  },
                                  onSubmitted: (text) {
                                    FocusScope.of(context).unfocus();
                                    showSuggestions = false;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                  focusNode: nodeTwo,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    hintText: "Enter drop-off point",
                                    border:
                                        OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                  controller: appState.destinationController,
                                  onTap: ()  {
                                    showSuggestions=true;
                                    _suggestion = _destinationList;
                                  },
                                  onChanged: (input) {
                                    getDestinationResults(input);
                                  },
                                  onSubmitted: (text) {
                                    FocusScope.of(context).unfocus();
                                    showSuggestions = false;
                                    appState.updateDestinationField(text, "");
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      !showSuggestions ? SizedBox(height: 1,) : Column(
                        children: <Widget>[
                          Container(
                            height: 400,
                            color: Colors.white.withOpacity(0.8),
                            child: ListView.builder(
                              shrinkWrap: false,
                              itemCount: _suggestion.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if(nodeTwo.hasFocus){
                                      appState.updateDestinationField(_suggestion[index].name, _suggestion[index].location);
                                    }else if (nodeOne.hasFocus){
                                      appState.updateDepartureField(_suggestion[index].name, _suggestion[index].location);
                                    }
                                    FocusScope.of(context).unfocus();
                                    showSuggestions = false;
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.add_location),
                                    title: Text(_suggestion[index].name ?? 'Error'),
                                    subtitle: Text(_suggestion[index].location ?? _suggestion[index].name ),
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            (appState.polyLines.isEmpty) 
            ? 
            Positioned(
              bottom: 4,
              left: 20,
              width: MediaQuery.of(context).size.width * 0.9,
              child: FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                onPressed: (){
                  if(appState.departureController.text.isEmpty || appState.destinationController.text.isEmpty){
                    final snackBar = SnackBar(
                      content: Text('Please input the fields'),
                    );
                    _key.currentState.showSnackBar(snackBar);
                  }else{
                    appState.sendRequest(appState.departureController.text, appState.destinationController.text);
                  }
                },
                color: Colors.green,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Get Route Details"),
                    Icon(Icons.book, color: Colors.white,)
                  ],
                ),
              ),
            ) 
            :
            Positioned(
              bottom: 4,
              left: 20,
              width: MediaQuery.of(context).size.width * 0.9,
              child: FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                onPressed: (){
                  if(appState.routeInfo.isEmpty){
                    final snackBar = SnackBar(
                      content: Text('Please input the fields'),
                    );
                    _key.currentState.showSnackBar(snackBar);
                  }else{
                    appState.createJourneyRecords();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RideInfo()),
                    );
                  }
                },
                color: Colors.blue,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Book this Ride"),
                    Icon(Icons.book, color: Colors.white,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MapsFullScreen extends StatefulWidget {
  @override
  _MapsFullScreenState createState() => _MapsFullScreenState();
}

class _MapsFullScreenState extends State<MapsFullScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: /*appState.initialPosition*/ LatLng(-1.2921, 36.8219), zoom: 11.5
      ),
      gestureRecognizers: Set()
      ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
      scrollGesturesEnabled: true,
      onMapCreated: appState.onCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      compassEnabled: false,
      markers: appState.markers,
      onCameraMove: appState.onCameraMove,
      polylines: appState.polyLines,
    );
  }
}

class StackedCards extends StatefulWidget {
  @override
  _StackedCardsState createState() => _StackedCardsState();
}

class _StackedCardsState extends State<StackedCards> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        color: Colors.white.withOpacity(0),),
        margin: EdgeInsets.only(bottom: 60, left: 100),
        height: 200,
        
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5)), 
              child: Container( 
                decoration: BoxDecoration(
                  color: Color.fromRGBO(24, 24, 45, 1),
                  borderRadius: BorderRadius.circular(5)),
                width: 220, 
                height: 100,
                
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                      child: Container(
                        color: Colors.white.withOpacity(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('Premium', style: TextStyle(color: Colors.white),),
                                Text('Ksh.${appState.premiumCost}', style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text('${appState.duration} ride', style: TextStyle(color: Colors.white),),
                              ],
                            ),                          
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5)),
                      child: Image.asset('assets/images/defloncars/landrover.png', fit: BoxFit.cover,),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                print('clicked!');
              },
              child: Material(
                child: Card(
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5)), 
                  child: Container( width: 220, height: 100,
                  color: Color.fromRGBO(24, 24, 45, 1),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                          child: Container(
                            color: Colors.white.withOpacity(0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text('Business', style: TextStyle(color: Colors.white),),
                                    Text('Ksh.${appState.businessCost}', style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('${appState.duration} ride', style: TextStyle(color: Colors.white),),                                
                                  ],
                                ),                          
                              ],       
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 50, top: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                          child: Image.asset('assets/images/defloncars/prado.png',),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5)), 
              child: Container( 
                width: 220, 
                height: 100,
                color: Color.fromRGBO(24, 24, 45, 1),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                      child: Container(
                        color: Colors.white.withOpacity(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('Economy', style: TextStyle(color: Colors.white),),
                                Text('Ksh.${appState.economyCost}', style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text('${appState.duration} ride', style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ],        
                        ),
                      ),
                    ),
                    Container(                     
                      margin: EdgeInsets.only(left: 80, top: 30),
                      decoration: BoxDecoration(
                      color: Color.fromRGBO(24, 24, 45, 1),
                        borderRadius: BorderRadius.circular(5)),
                      child: Image.asset('assets/images/defloncars/Benz.png', fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}