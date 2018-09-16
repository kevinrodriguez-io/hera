import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/TodoItem.dart';

class HomePage extends StatefulWidget {
  HomePage({this.app});
  final FirebaseApp app;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference _itemRef;
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      _user = user;
      _itemRef = FirebaseDatabase(app: widget.app)
          .reference()
          .child('/users/' + _user.uid + '/todos');
    });
  }

  Widget renderContent() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: FirebaseAnimatedList(
        query: _itemRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          TodoItem todoItem = TodoItem.fromSnapshot(snapshot);
          return CheckboxListTile(
            value: todoItem.complete,
            title: Text(todoItem.title),
            subtitle: Text(todoItem.description),
            onChanged: (bool) {
              todoItem.complete = !todoItem.complete;
              String todoItemKey = todoItem.key;
              FirebaseDatabase.instance
                  .reference()
                  .child("/users/" + _user.uid + "/todos/$todoItemKey/")
                  .set(todoItem.toJson());
            },
          );
        },
      ),
    );
  }
}
