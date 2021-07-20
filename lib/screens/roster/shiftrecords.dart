import 'package:flutter/material.dart';
import 'package:golfandtango/services/auth.dart';

class ShiftRecords extends StatefulWidget {
  @override
  _ShiftRecordsState createState() => _ShiftRecordsState();
}

class _ShiftRecordsState extends State<ShiftRecords> {
  final AuthService _auth = AuthService();
  bool isOnShift = false;
  DateTime startOfShift;
  DateTime endOfShift;
  var lengthOfShift;

  //Get length of shift in minutes
  int getLengthOfShift(DateTime inputStartOfShift, DateTime inputEndOfShift) {
    inputStartOfShift = DateTime(inputStartOfShift.day, inputStartOfShift.hour,
        inputStartOfShift.minute);
    inputEndOfShift = DateTime(
        inputEndOfShift.day, inputEndOfShift.hour, inputEndOfShift.minute);
    return (inputEndOfShift.difference(inputStartOfShift).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start/End Shifts'),
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
      body: ListView(
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                if (isOnShift == false) {
                  setState(() => startOfShift = DateTime.now());
                  setState(() => isOnShift = true);
                } else {
                  lengthOfShift = "Already on Shift";
                }
              },
              child: Text('Start Shift')),
          ElevatedButton(
              onPressed: () {
                setState(() => endOfShift = DateTime.now());
                isOnShift = false;
                lengthOfShift = getLengthOfShift(startOfShift, endOfShift);
              },
              child: Text('End Shift')),
          Text(' $startOfShift'),
          Text(' $endOfShift'),
          Text(' $lengthOfShift')
        ],
      ),
    );
  }
}
