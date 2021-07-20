import 'package:firebase_auth/firebase_auth.dart';
import 'package:golfandtango/models/appuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// create user object based on FirebaseUser
  Appuser _userFromFirebaseUser(User user) {
    return user != null ? Appuser(uid: user.uid) : null;
  }

// auth change user stream
  Stream<Appuser> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

//sign in with email & password

  Future signInWithUsernameAndPassword(String username, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      User user = result.user;
      FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((dataSnapshot) {});
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email and password

  Future registerWithUsernameAndPassword(
      String username, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: username, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
