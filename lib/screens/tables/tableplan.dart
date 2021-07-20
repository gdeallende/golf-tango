import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:golfandtango/services/auth.dart';

class TablePlan extends StatefulWidget {
  @override
  _TablePlanState createState() => _TablePlanState();
}

class _TablePlanState extends State<TablePlan> {
  final AuthService _auth = AuthService();

  var top = 10.0;
  var left = 10.0;
  var twotop = 60.0;
  var twoleft = 60.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Plan'),
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
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: top,
                left: left,
                child: Container(width: 70, height: 70, color: Colors.brown),
              ),
            ],
          ),
          onVerticalDragUpdate: (DragUpdateDetails one) {
            setState(() {
              top = one.localPosition.dy;
              left = one.localPosition.dx;
            });
          },
        ),
      ),
    );
  }
}
