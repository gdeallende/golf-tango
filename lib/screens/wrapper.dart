import 'package:flutter/material.dart';
import 'package:golfandtango/screens/authenticate/authenticate.dart';
import 'package:golfandtango/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:golfandtango/models/appuser.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Appuser>(context);
    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
