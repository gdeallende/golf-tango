import 'package:flutter/material.dart';
import 'package:golfandtango/assistanceFunctions/sharedpref.dart';
import 'package:golfandtango/screens/Menu/menuhome.dart';
import 'package:golfandtango/screens/News/shownews.dart';
import 'package:golfandtango/screens/News/updatenews.dart';
import 'package:golfandtango/screens/chatscreen/chathome.dart';
import 'package:golfandtango/screens/profilepage.dart';
import 'package:golfandtango/screens/roster/shiftrecords.dart';
import 'package:golfandtango/screens/tables/tableplan.dart';
import 'package:golfandtango/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      appBar: AppBar(
        title: Text('Golf and Tango'),
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bramble.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 100),
            ElevatedButton(
              child: Text('Tables'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TablePlan()));
              },
            ),
            ElevatedButton(
              child: Text('Menu'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MenuCatagories()));
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('News'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewsPage()));
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Roster'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShiftRecords()));
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Reservations'),
              onPressed: () {
                print('Pressed');
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('My Profile'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
                print(SharedPreferenceAssistant.firstNameKey);
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('CHAT!!!!'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Chatscreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
