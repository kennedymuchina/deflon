import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
  static final FireStoreService _fireStoreService = FireStoreService._internal();
  Firestore _db = Firestore.instance;
  FireStoreService._internal();

  factory FireStoreService(){
    return _fireStoreService;
  }


  Stream<List<Journey>> getJourneyInfo() {
    return _db.collection('journeys')
      .snapshots()
      .map((snapshot) => snapshot.documents.map((doc) => Journey.fromMap(doc.data, doc.documentID)).toList());
  }
}


class Journey {
  final String customer;
  final String distance;
  final String driver;
  final String duration;
  final String endLocationLatLng;
  final String endLocationtxt;
  final String startLocationLatLng;
  final String startLocationtxt;
  final String status;
  final String id;

  Journey({this.customer, this.distance, this.driver, this.duration, this.endLocationLatLng,
  this.endLocationtxt, this.startLocationLatLng, this.startLocationtxt, this.status, this.id});
  Journey.fromMap(Map<String, dynamic> data, String id):
    customer = data['customer'],
    distance = data['distance'],
    driver = data['driver'],
    duration = data['duration'],
    endLocationLatLng = data['endLocationLatLng'],
    endLocationtxt = data['endLocationtxt'],
    startLocationLatLng = data['startLocationLatLng'],
    startLocationtxt = data['startLocationtxt'],
    status = data['status'],
    id = id;
}