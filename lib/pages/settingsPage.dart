import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: (
          ListView(
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
                textColor: Theme.of(context).accentColor,
                onPressed: (){},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Log Out', style: TextStyle(color: Colors.redAccent),),
                    Spacer(),
                    Icon(Icons.exit_to_app, color: Colors.redAccent,)
                  ],
                )
                //Text('Log out'),
              )
            ],
          )
        ),
      ),
    );
  }
}
