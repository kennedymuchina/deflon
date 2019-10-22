// import 'package:deflon/models/users.dart';
// import 'package:deflon/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;

  Status _status = Status.Uninitialized;

  UserProvider.initialize():_auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;
  // UserServices _userServices;
  Firestore _fireStore = Firestore.instance;
  String collection = "users";

  Future<bool>signIn(String email, String password) async{
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = Status.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

    Future<bool>signUp(String name, String email, String password) async{
    try{
      _status = Status.Authenticating;
      notifyListeners();

      //create our user
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = Status.Authenticated;

      // create a user in the database.
      // update our user info
      Map<String, dynamic> values = {
        "name": name,
        "email": email,
        "userId": user.uid
      };

      _fireStore.collection(collection).document(values['userId']).setData(values);
      notifyListeners();
      return true;
    }catch (e) {
      // this should bring them back to the signup page
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut()async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }



  Future<void> _onStateChanged(FirebaseUser user) async{
    if(user == null){
      _status = Status.Unauthenticated;
    }else{
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}