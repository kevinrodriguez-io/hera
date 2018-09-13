import 'package:flutter/material.dart';
import '../widgets/hiddenScrollBehavior.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  FlutterLogoStyle logoStyle = FlutterLogoStyle.markOnly;

  _animateFlutterLogo() {
    setState(() {
      if (logoStyle == FlutterLogoStyle.markOnly) {
        logoStyle = FlutterLogoStyle.horizontal;
      } else {
        logoStyle = FlutterLogoStyle.markOnly;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
          child: ListView(
            children: <Widget>[
              FlutterLogo(
                style: logoStyle,
                size: 200.0,
              ),
              TextField(
                autocorrect: false,
                focusNode: usernameFocusNode,
                decoration: InputDecoration(labelText: 'Username'),
                keyboardType: TextInputType.emailAddress,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
              TextField(
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
                  style: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
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
        ),
      ),
    );
  }
}
