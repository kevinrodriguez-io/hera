import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _currentUsername = '';

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        _currentUsername = user.email;
      });
    });
  }

  _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/register');
  }

  _switchTheme(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: (ListView(
          children: <Widget>[
            FlutterLogo(
              style: FlutterLogoStyle.stacked,
              size: 100.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Hera app built with love by kevinrodriguez-io \nThis app uses the concept of 'pages', some of you might be familiar if you are coming from a Xamarin / IONIC background. In this case we have routes, themes, navigation, login and register. Firebase integration coming soon.",
                style: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
              ),
            ),
            FlatButton(
                onPressed: _logout,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Log Out',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    Spacer(),
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.redAccent,
                    )
                  ],
                )
                //Text('Log out'),
                ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Logged in as: $_currentUsername",
                style: TextStyle(color: Color.fromARGB(255, 200, 200, 200)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
