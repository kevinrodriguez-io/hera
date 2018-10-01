import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItem {
  String id;
  String title = '';
  String description = '';
  bool complete = false;

  TodoItem(this.title, {this.description, this.complete});

  TodoItem.from(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        title = snapshot['title'],
        description = snapshot['description'],
        complete = snapshot['complete'];

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'complete': complete};
  }
}
