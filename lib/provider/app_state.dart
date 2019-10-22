
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart' as prefix0;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:deflon/services/gmap_requests.dart';
import 'package:flutter/services.dart' show rootBundle;
class AppState with ChangeNotifier {
  var user;
  Location location = Location();
  static LatLng _initialPosition;
  final Set<Marker> _markers = {};
  Marker marker;
  final Set<Polyline> _polyLines = {};
  LatLng _pickup;
  LatLng _destination;
  LatLng _lastPosition = _initialPosition;
  String positionText;
  String _mapStyle;
  Map <String, dynamic> _routeInfo;
  double _premiumCost;
  double _businessCost;
  double _economyCost;
  String _distance;
  String _duration;
  MidPoint _midPoint;
  var _dur;
  var _dist;

  GoogleMapsServices _googleMapsServices = GoogleMapsServices();

  GoogleMapController _mapController;
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _departureController = TextEditingController();

  TextEditingController get departureController => _departureController;
  TextEditingController get destinationController => _destinationController;
  LatLng get initialPosition => _initialPosition;
  String get distance => _distance;
  String get duration => _duration;
  dynamic get premiumCost => _premiumCost;
  dynamic get businessCost => _businessCost;
  dynamic get economyCost => _economyCost;
  MidPoint get midPoint => _midPoint;
  dynamic get dur => _dur;
  double get dist => _dist;
  LatLng get lastPosition => _lastPosition;
  LatLng get destination => _destination;
  Map<String, dynamic> get routeInfo => _routeInfo;
  LatLng get pickup => _pickup;
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;

  AppState() {
    _getUserLocation();
    styletheMaps();
  }

  void styletheMaps(){
  rootBundle.loadString('assets/maps/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }
  // ! Get the Mid Point so that we can center the Polylines automatically.
  void getTheMidpoint(){
    final x = MidPoint(pickup.latitude, pickup.longitude);
    final y = MidPoint(destination.latitude, destination.longitude);

    var mx = x.midpt(y).x;
    var my = x.midpt(y).y;
    // print('${x.midpt(y).x}, ${x.midpt(y).y}');
    _midPoint = MidPoint(mx, my);
  }

  void updateDestinationField(text, detail){
    destinationController.text = text + ", " + detail;
    notifyListeners();
  }

  void updateDepartureField(text, detail){
    departureController.text = text + ", " + detail;
    notifyListeners();
  }

// ! TO GET THE USERS LOCATION
  void _getUserLocation() async{
    prefix0.Position position = await prefix0.Geolocator().getCurrentPosition(desiredAccuracy: prefix0.LocationAccuracy.high);
    // List<Placemark> placemark = await prefix0.Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    notifyListeners();
  }

  // ! TO CREATE ROUTE
  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 5,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.lightBlueAccent));
    notifyListeners();
  }

  // ! ADD A MARKER ON THE MAO5
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "To here"),
        icon: BitmapDescriptor.defaultMarker));
    _markers.add(Marker(
        markerId: MarkerId(_pickup.toString()),
        position: pickup,
        infoWindow: InfoWindow(title: '$_pickup', snippet: "From here"),
        icon: BitmapDescriptor.defaultMarker,
    ));
    notifyListeners();
  }

  // ! CREATE LAGLNG LIST
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    // repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    /*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    return lList;
  }

  // ! SEND REQUEST
  void sendRequest(String pickupLocation, String intendedLocation) async {
    _markers.clear();
    _polyLines.clear();
    List<Placemark> placemark = await Geolocator().placemarkFromAddress(intendedLocation);
    List<Placemark> placemark2 = await Geolocator().placemarkFromAddress(pickupLocation);

    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    double latitude2 = placemark2[0].position.latitude;
    double longitude2 = placemark2[0].position.longitude;

    _destination = LatLng(latitude, longitude);
    _pickup = LatLng(latitude2, longitude2);

    _addMarker(destination, intendedLocation);
    _addMarker(pickup, pickupLocation);

    String route = await _googleMapsServices.getRouteCoordinates(_pickup, _destination);

  // CALCULATE THE COST OF THE JOURNEY
    String timeRequest = 'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$pickupLocation&destinations=$intendedLocation&key=AIzaSyCMdlx7S5rSjaRqNwBk2_OmaBa5MHNp8VI';
    Response response = await Dio().get(timeRequest);

    print(response.data['rows'][0]['elements'][0]['duration']['text']);
    _duration = response.data['rows'][0]['elements'][0]['duration']['text'];
    _dur = int.parse(duration.replaceAll(RegExp(r'[A-Za-z]\s*'), ''));
   

    _distance = response.data['rows'][0]['elements'][0]['distance']['text'];
    print(distance);
    _dist = double.parse(distance.replaceAll(RegExp(r'[A-Za-z]\s*'), ''));


    if (duration.contains('mins')) {
      _premiumCost = ((4000.0 + (dur/100) * 3000)/100).roundToDouble() * 100;
      _businessCost = ((2800.0 + (dur/100) * 2000)/100).roundToDouble() * 100;
      _economyCost = ((2000.0 + (dur/100) * 1200)/100).roundToDouble() * 100;
    } else if (duration.contains('hour') || duration.contains('hours')){
      _premiumCost = ((4000.0 + (dur * 2000)/100).roundToDouble() *100);
      _businessCost = ((2800.0 + (dur * 1700)/100).roundToDouble() *100);
      _economyCost = ((2000.0 + (dur * 1500)/100).roundToDouble() *100);
    }

    if(response.data['status'] == 'OK'){
      _routeInfo = {
        'startLocationtxt' : pickupLocation,
        'endLocationtxt': intendedLocation,
        'startLocationLatLng' : '$_pickup',
        'endLocationLatLng' : '$_destination',
        'distance' : dist,
        'duration' : dur,
        'estimated_premium_cost' : premiumCost,
        'estimated_business_cost' : businessCost,
        'estimated_economy_cost' : economyCost,
      };
      print(routeInfo);
      
    }
    createRoute(route);
    moveCamera();
    getTheMidpoint();
    notifyListeners();
  }

  // ! CREATE A RECORD FOR THE JOURNEY ---------------------
  void createJourneyRecords() async{
    final databaseReference = Firestore.instance;
    await databaseReference.collection('Journeys')
      .document('${DateTime.now().millisecondsSinceEpoch}')
      .setData(routeInfo);
  }

  // ! MOVE CAMERA TO THE NEW LOCATION ---------------------
  void moveCamera() async {
    CameraUpdate u2 = CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: (pickup.latitude <= destination.latitude) ? pickup :destination, 
        northeast: (pickup.latitude >= destination.latitude) ? pickup : destination
      ), 
      10
    );
    check(u2, mapController);
  }

  void check(CameraUpdate u, GoogleMapController m) async {
    mapController.animateCamera(u);
    LatLngBounds l1=await mapController.getVisibleRegion();
    LatLngBounds l2=await mapController.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if(l1.southwest.latitude==-90 || l2.southwest.latitude==-90)
      check(u, m);
  }

  // ! --------------------------------------------------------

  // ! ON CAMERA MOVE------------------------------------------
  void onCameraMove(CameraPosition position) {
    _pickup = position.target;
    notifyListeners();
  }

  // ! ON CREATE-----------------------------------------------
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.setMapStyle(_mapStyle);
    notifyListeners();
  }
}

// ---------------------------------------------
// Api for distance calculation
// ---------------------------------------------
// https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=_pickup&destinations=_destination&key=AIzaSlllyCMdlx7S5rSjaRqNwBk2_OmaBa5MHNp8VI
// ---------------------------------------------
// ---------------------------------------------

class MidPoint {
  num x, y;

  MidPoint(this.x, this.y);

  num distanceTo(MidPoint other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
  
  MidPoint midpt(MidPoint other) {
    var mx = (x + other.x)/2;
    var my = (y + other.y)/2;
    return MidPoint(mx, my);
  }
}