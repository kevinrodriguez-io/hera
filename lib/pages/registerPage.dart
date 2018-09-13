import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username;
  String password;

  FlutterLogoStyle logoStyle = FlutterLogoStyle.horizontal;

  _animateFlutterLogo() {
    setState(() {
      logoStyle = (logoStyle == FlutterLogoStyle.markOnly)
          ? FlutterLogoStyle.horizontal
          : FlutterLogoStyle.markOnly;
    });
  }

  @override
  void initState() {
    super.initState();
    runAnimationAfter2s(); //
  }

  void runAnimationAfter2s() async {
    await Future.delayed(Duration(seconds: 2), () {
      _animateFlutterLogo();
    });
  }

  void registerUser() async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Registering user'),));
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      return;
    }
    form.save();
    try {
      FirebaseUser _ = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: username, password: password);
      Navigator.of(context).pushReplacementNamed('/maintabs');
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
        duration: Duration(seconds: 10),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: registerUser,
        child: Icon(Icons.person_add),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
          child: Text("I already have an account"),
        ),
      ],
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ScrollConfiguration(
            behavior: HiddenScrollBehavior(),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  FlutterLogo(
                    style: logoStyle,
                    size: 200.0,
                  ),
                  TextFormField(
                    onSaved: (val) { setState(() { username = val; }); },
                    validator: (val) => val == "" ? val : null,
                    autocorrect: false,
                    focusNode: usernameFocusNode,
                    decoration: InputDecoration(labelText: 'Username'),
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                  TextFormField(
                    onSaved: (val) { setState(() { password = val; }); },
                    validator: (val) => val == "" ? val : null,
                    focusNode: passwordFocusNode,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Hera app, with love by kevinrodriguez-io source code available at: https://github.com/kevinrodriguez-io/hera",
                      style:
                          TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Register with Facebook'),
                    onPressed: () {},
                    color: Color.fromARGB(255, 59, 89, 152),
                    textColor: Colors.white,
                  ),
                  FlatButton(
                      child: Text('Animate flutter logo'),
                      onPressed: _animateFlutterLogo,
                      textColor: Colors.blueGrey),
                ],
              ),
            )),
      ),
    );
  }
}
