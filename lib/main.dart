// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:horizon/shared_pref/pref_save.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:horizon/signup/signup.dart';
import 'package:horizon/ui_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: logCheck(),
    );
  }
}

class logCheck extends StatefulWidget {
  @override
  _logCheckState createState() => _logCheckState();
}

class _logCheckState extends State<logCheck> {
  bool userLoggedIn = false;
  @override
  void initState() {
    userLogged();
    Timer(
        Duration(milliseconds: 10),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => userLoggedIn ? HomePage() : SignUp())));
    super.initState();
  }

  userLogged() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      if (value != null) {
        setState(() {
          userLoggedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
