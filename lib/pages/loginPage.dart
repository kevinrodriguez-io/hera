import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username;
  String password;
  bool isLoggingIn = false;

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
    _runAnimationAfter2s(); //
  }

  void _runAnimationAfter2s() async {
    await Future.delayed(Duration(seconds: 2), () {
      _animateFlutterLogo();
    });
  }

  void _logIn() async {
    if (isLoggingIn) return;
    setState(() {
      isLoggingIn = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Logging in'),
    ));

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        isLoggingIn = false;
      });
      return;
    }

    form.save();

    try {
      FirebaseUser _ = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/maintabs');
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ));
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Log in'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _logIn,
        child: Icon(Icons.account_circle),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("I don't have an account"),
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
                    onSaved: (val) {
                      setState(() {
                        username = val;
                      });
                    },
                    validator: (val) =>
                        val == "" ? 'Please enter a valid email' : null,
                    autocorrect: false,
                    focusNode: usernameFocusNode,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                  TextFormField(
                    onSaved: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                    validator: (val) =>
                        val == "" ? 'Please enter a valid password' : null,
                    focusNode: passwordFocusNode,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Welcome to Hera app!, with love by kevinrodriguez-io\nSource code available at: https://github.com/kevinrodriguez-io/hera",
                      style:
                          TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Log in with Facebook'),
                    onPressed: () {},
                    color: Color.fromARGB(255, 59, 89, 152),
                    textColor: Colors.white,
                  ),
                  FlatButton(
                      child: Text('I forgot my password'),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/forgotpassword');
                      },
                      textColor: Colors.blueGrey),
                ],
              ),
            )),
      ),
    );
  }
}
