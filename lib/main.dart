import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:golfandtango/screens/wrapper.dart';
import 'package:golfandtango/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:golfandtango/models/appuser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Appuser>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
