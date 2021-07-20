import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golfandtango/models/appuser.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
//collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

//update the firebase "Users" collection
  Future updateUserData(String firstName, String lastName, String displayName,
      String email, String profileUrl) async {
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'email': email,
      'profilePic': profileUrl,
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("Convos")
        .doc(chatRoomId)
        .set(chatRoomMap);
  }

  //Return a snapshot of the users matching the displayname entered
  Future<Stream<QuerySnapshot>> getUserWithUsername(String username) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .where("displayName", isEqualTo: username)
        .snapshots();
  }

  getUserWithEmail(String email) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .where("email", isEqualTo: email)
        .get();
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("Users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  Future addMessage(
      String chatThreadId, String messageId, Map messageInformation) {
    return FirebaseFirestore.instance
        .collection("Chatrooms")
        .doc(chatThreadId)
        .collection("Messages")
        .doc(messageId)
        .set(messageInformation);
  }

  //userDetails from snapshot

  UserDetails _userDetailsFromSnapshot(DocumentSnapshot snapshot) {
    return UserDetails(
      uid: uid,
      firstName: snapshot["firstName"],
      lastName: snapshot["lastName"],
      displayName: snapshot["displayName"],
      email: snapshot["email"],
      profilePic: snapshot["profilePic"],
    );
  }

  // get user document stream
  Stream<UserDetails> get userDetails {
    return userCollection.doc(uid).snapshots().map(_userDetailsFromSnapshot);
  }

  Future<void> addNews(newsData) async {
    FirebaseFirestore.instance.collection("news").add(newsData).catchError((e) {
      print(e);
    });
  }

  getNews() async {
    return await FirebaseFirestore.instance.collection("news").get();
  }
}
