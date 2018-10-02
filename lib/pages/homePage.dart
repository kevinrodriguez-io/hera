import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hera/models/TodoItem.dart';
import 'addToDo/addToDoAlertDialog.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  CollectionReference _todosRef;
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) async {
      setState(() {
        _user = user;
        _todosRef = Firestore.instance
            .collection('users')
            .document(_user.uid)
            .collection('todos');
      });
    });
  }

  void _addTodo(BuildContext context) async {
    TodoItem item = await showDialog(
      context: context,
      builder: (_) => AddTodoAlertDialog(),
    );
    if (item != null) {
      await _todosRef.add(item.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('My To-Do list'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo(context);
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: (_todosRef == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder(
                stream: _todosRef.where('archived', isEqualTo: false).snapshots(),
                builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) =>
                    (!snapshot.hasData)
                        ? Center(child: CircularProgressIndicator())
                        : (snapshot.data.documents.length == 0)
                            ? EmptyTodoList()
                            : ListView(
                                children: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  TodoItem item = TodoItem.from(document);
                                  return Dismissible(
                                    key: Key(item.id),
                                    background: Container(
                                      color: Theme.of(context).primaryColorDark,
                                      child: Center(
                                        child: Text(
                                          'Archive',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      // document.reference.delete();
                                      document.reference.updateData({"archived": true});
                                    },
                                    child: Card(
                                      child: CheckboxListTile(
                                        title: Text(item.title),
                                        subtitle: Text(item.description),
                                        value: document['complete'],
                                        onChanged: (bool value) {
                                          document.reference
                                              .updateData({"complete": value});
                                        },
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
              ),
      ),
    );
  }
}

class EmptyTodoList extends StatelessWidget {

  const EmptyTodoList({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.check,
          size: 45.0,
          color: Colors.blueGrey,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
        ),
        Text(
          'It looks like you have no todos',
          style: TextStyle(
            color: Colors.blueGrey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
