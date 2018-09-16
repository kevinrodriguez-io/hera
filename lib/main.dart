import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/registerPage.dart';
import 'theme.dart';
import 'routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/mainTabsPage.dart';

Future<void> main() async {
  FirebaseApp app = await FirebaseApp.configure(
    name: 'db',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:297855924061:ios:c6de2b69b03a5be8',
            gcmSenderID: '297855924061',
            databaseURL: 'https://herafirebase.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:702278671612:android:093c8fcab893071c',
            apiKey: 'AIzaSyAV271a00VLT-d6ItcnfsGV0nR9aseF98o',
            databaseURL: 'https://herafirebase.firebaseio.com',
          ),
  );
  runApp(new HeraApp(
    app: app,
  ));
}

class HeraApp extends StatefulWidget {
  HeraApp({this.app});

  final FirebaseApp app;

  @override
  State<StatefulWidget> createState() => _HeraAppState();
}

class _HeraAppState extends State<HeraApp> {
  Widget rootPage = RegisterPage();

  Future<Widget> getRootPage() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      return MainTabsPage(app: widget.app);
    } else {
      return RegisterPage();
    }
  }

  @override
  void initState() {
    super.initState();
    getRootPage().then((Widget value) {
      setState(() {
        rootPage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: buildAppTheme(),
        routes: buildAppRoutes(),
        home: rootPage);
  }
}
