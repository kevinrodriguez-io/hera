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
        child: Card(
          elevation: 3.0,
          child: (_todosRef == null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : StreamBuilder(
                  stream: _todosRef.snapshots(),
                  builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) =>
                      (!snapshot.hasData)
                          ? Center(child: CircularProgressIndicator())
                          : ListView(
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                TodoItem item = TodoItem.from(document);
                                return CheckboxListTile(
                                  title: Text(item.title),
                                  subtitle: Text(item.description),
                                  value: document['complete'],
                                  onChanged: (bool value) {
                                    document.reference
                                        .updateData({"complete": value});
                                  },
                                );
                              }).toList(),
                            ),
                ),
        ),
      ),
    );
  }
}
