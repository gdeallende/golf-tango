import 'package:flutter/material.dart';
import 'package:golfandtango/screens/authenticate/sign_in.dart';
import 'package:golfandtango/services/auth.dart';
import 'package:golfandtango/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:golfandtango/assistanceFunctions/sharedpref.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final SharedPreferenceAssistant sharedPreferences =
      new SharedPreferenceAssistant();

  final _registerFormKey = GlobalKey<FormState>();

//Various fields
  String username = '';
  String password = '';
  String userError = '';
  String displayName = '';
  String lastName = '';
  String firstName = '';
  int age = 0;
  String profilePic = 'assets/four_tumblers.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text('Register GnT Account!'),
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              }),
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _registerFormKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 10.0),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email...',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow[800], width: 1.0)),
                    ),
                    validator: (input) =>
                        input.isEmpty ? 'Email Required!' : null,
                    onChanged: (input) {
                      setState(() => username = input);
                    }),
                SizedBox(height: 10.0),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password...',
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
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'First Name...',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.yellow[800], width: 1.0)),
                    ),
                    validator: (input) =>
                        input.isEmpty ? 'First name required!' : null,
                    onChanged: (input) {
                      setState(() => firstName = input);
                    }),
                SizedBox(height: 10.0),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Last Name...',
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
                      hintText: 'Display Name...',
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
                      setState(() => profilePic = "\"" + input + "\"");
                    }),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.yellow[800]),
                    child: Text(
                      'Register',
                    ),
                    onPressed: () async {
                      if (_registerFormKey.currentState.validate()) {
                        dynamic result =
                            await _auth.registerWithUsernameAndPassword(
                                username, password);
                        SharedPreferenceAssistant.saveEmail(username);
                        print(SharedPreferenceAssistant.userEmailKey);
                        _auth.signOut();

                        if (result == null) {
                          setState(() =>
                              userError = 'Incorrect username or password');
                        }
                      }

                      User currentUser = FirebaseAuth.instance.currentUser;
                      DatabaseService(uid: currentUser.uid)
                          .updateUserData(firstName, lastName, displayName,
                              username, profilePic)
                          .then((s) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
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
