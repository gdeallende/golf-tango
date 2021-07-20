import 'package:flutter/material.dart';
import 'package:golfandtango/assistanceFunctions/sharedpref.dart';
import 'package:golfandtango/screens/authenticate/register.dart';
import 'package:golfandtango/services/auth.dart';
import 'package:golfandtango/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final SharedPreferenceAssistant pref = SharedPreferenceAssistant();
  final DatabaseService _database = DatabaseService();
  final _signInFormKey = GlobalKey<FormState>();

  QueryDocumentSnapshot snapshotUserInfo;

  //Username and password Field State
  String email = '';
  String password = '';
  String signInError = '';

  Stream currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: Text(' Golf and Tango: Sign In'),
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(Icons.person),
              label: Text(
                'Register',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              }),
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/four_tumblers.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            ),
          ),
          child: Form(
            key: _signInFormKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 150.0),
                TextFormField(
                    style: TextStyle(fontSize: 20.0, color: Colors.yellow[800]),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: Colors.yellow[800]),
                      focusColor: Colors.yellow[800],
                      fillColor: Colors.grey[600].withOpacity(0.5),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow[800], width: 1.0)),
                    ),
                    validator: (input) =>
                        input.isEmpty ? 'Email Required!' : null,
                    onChanged: (input) {
                      setState(() => email = input);
                    }),
                SizedBox(height: 10.0),
                TextFormField(
                    style: TextStyle(fontSize: 20.0, color: Colors.yellow[800]),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: Colors.yellow[800]),
                      fillColor: Colors.grey[600].withOpacity(0.5),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow[800], width: 1.0)),
                    ),
                    validator: (input) => input.length < 6
                        ? 'Password needs to be 6+ characters'
                        : null,
                    obscureText: true,
                    onChanged: (input) {
                      setState(() => password = input);
                    }),
                SizedBox(height: 10.0),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.yellow[800]),
                    child: Text(
                      'Sign in',
                    ),
                    onPressed: () async {
                      if (_signInFormKey.currentState.validate()) {
                        SharedPreferenceAssistant.saveEmail(email);
                        _database.getUserWithEmail(email).then((val) {
                          snapshotUserInfo = val;
                          SharedPreferenceAssistant.saveDisplayName(
                              snapshotUserInfo['displayName']);
                          SharedPreferenceAssistant.saveFirstName(
                              snapshotUserInfo["firstName"]);
                          SharedPreferenceAssistant.saveLastName(
                              snapshotUserInfo["lastName"]);
                          SharedPreferenceAssistant.saveProfilePic(
                              snapshotUserInfo["profilePic"]);
                          print(snapshotUserInfo["email"]);
                          print(snapshotUserInfo["firstName"]);
                        });
                        dynamic result = await _auth
                            .signInWithUsernameAndPassword(email, password)
                            .then((s) {
                          print(SharedPreferenceAssistant.firstNameKey);
                        });

                        if (result == null) {
                          setState(() =>
                              signInError = 'Incorrect username or password');
                        }
                      }
                    }),
                SizedBox(height: 10.0),
                Text(
                  signInError,
                  style: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              ],
            ),
          )),
    );
  }
}
