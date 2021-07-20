import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golfandtango/assistanceFunctions/sharedpref.dart';
import 'package:golfandtango/screens/home/home.dart';
import 'package:golfandtango/services/auth.dart';
import 'package:golfandtango/services/database.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();
  final SharedPreferenceAssistant sharedPreferences =
      SharedPreferenceAssistant();

  final _updateFormKey = GlobalKey<FormState>();

//Various fields
  String userError = '';
  String email = '';
  String displayName = '';
  String lastName = '';
  String firstName = '';
  String profilePic = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.yellow[700],
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _updateFormKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 10.0),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: SharedPreferenceAssistant.firstNameKey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow[800], width: 1.0)),
                    ),
                    validator: (input) =>
                        input.isEmpty ? 'First name required!' : null,
                    onChanged: (input) {
                      if (input != null) {
                        setState(() => firstName = input);
                      } else {
                        setState(() =>
                            firstName = SharedPreferenceAssistant.firstNameKey);
                      }
                    }),
                SizedBox(height: 10.0),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: SharedPreferenceAssistant.lastNameKey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow[800], width: 1.0)),
                    ),
                    validator: (input) =>
                        input.isEmpty ? 'Last name required!' : null,
                    onChanged: (input) {
                      setState(() => lastName = input);
                    }),
                SizedBox(height: 10.0),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: SharedPreferenceAssistant.displayNameKey,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow[800], width: 1.0)),
                    ),
                    validator: (input) => input.length < 4
                        ? 'Name needs to be 4+ characters'
                        : null,
                    onChanged: (input) {
                      setState(() => displayName = input);
                    }),
                SizedBox(height: 10.0),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Profile Pic URL...',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow[800], width: 1.0)),
                    ),
                    onChanged: (input) {
                      setState(() => profilePic = input);
                    }),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.yellow[800]),
                    child: Text(
                      'Update Profile',
                    ),
                    onPressed: () {
                      if (_updateFormKey.currentState.validate()) {}

                      User currentUser = FirebaseAuth.instance.currentUser;
                      DatabaseService(uid: currentUser.uid)
                          .updateUserData(firstName, lastName, displayName,
                              email, profilePic)
                          .then((s) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));

                        SharedPreferenceAssistant.saveFirstName(firstName);
                        SharedPreferenceAssistant.saveLastName(lastName);
                        SharedPreferenceAssistant.saveDisplayName(displayName);
                        SharedPreferenceAssistant.saveProfilePic(profilePic);
                      });
                    }),
                SizedBox(height: 10.0),
                Text(
                  userError,
                  style: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              ],
            ),
          )),
    );
  }
}
