import 'package:flutter/material.dart';
import './pages/registerPage.dart';
import './theme.dart';

void main() => runApp(new HeraApp());

class HeraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: createAppTheme(),
      home: RegisterPage(),
    );
  }
}
