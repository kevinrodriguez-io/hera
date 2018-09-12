import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

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
        title: Text('Log in'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.exit_to_app),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("I don't have an account"),
        ),
      ],
      body: Container(
        padding: EdgeInsets.all(20.0),
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
              child: Text('Log in with Facebook'),
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
    );
  }
}
