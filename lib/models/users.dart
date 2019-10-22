import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  Firestore _fireStore = Firestore.instance;
  String collection = "users";
  void createUser(Map data) {
    _fireStore.collection(collection).document("userId").setData(data);
  }
}

Firestore _firestore = Firestore.instance;

Future<int> authenticateUser(String email, String password) async {
  final QuerySnapshot result = await _firestore
      .collection("users")
      .where("email", isEqualTo: email)
      .getDocuments();
  final List<DocumentSnapshot> docs = result.documents;
  if (docs.length == 0) {
    return 0;
  } else {
    return 1;
  }
}