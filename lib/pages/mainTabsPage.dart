import 'package:flutter/material.dart';
import 'homePage.dart';
import 'historyPage.dart';
import 'settingsPage.dart';

class MainTabsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainTabsPageState();
}

class _MainTabsPageState extends State<MainTabsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: new Scaffold(
          body: TabBarView(
            children: <Widget>[
              HomePage(),
              HistoryPage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: PreferredSize(
              preferredSize: Size(60.0, 60.0),
              child: Container(
                  height: 60.0,
                  child: TabBar(
                    labelColor: Colors.blueGrey,
                    labelStyle: TextStyle(fontSize: 10.0),
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.list),
                        text: 'Todos',
                      ),
                      Tab(
                        icon: Icon(Icons.history),
                        text: 'History',
                      ),
                      Tab(
                        icon: Icon(Icons.settings),
                        text: 'Settings',
                      ),
                    ],
                  ),
                  color: Theme.of(context).dialogBackgroundColor)),
        ),
      ),
    );
  }
}
