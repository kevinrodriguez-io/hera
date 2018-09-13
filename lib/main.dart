import 'dart:async';

import 'package:flutter/material.dart';
import './pages/registerPage.dart';
import './theme.dart';
import './routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './pages/mainTabsPage.dart';

void main() => runApp(new HeraApp());

class HeraApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HeraAppState();
}

class _HeraAppState extends State<HeraApp> {
  Widget rootPage = RegisterPage();

  Future<Widget> getRootPage() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      return MainTabsPage();
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
