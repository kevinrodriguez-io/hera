import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItem {
  String id;
  String title = '';
  String description = '';
  bool archived = false;
  bool complete = false;

  TodoItem(this.title, {this.description, this.complete, this.archived});

  TodoItem.from(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        title = snapshot['title'],
        description = snapshot['description'],
        archived = snapshot['archived'],
        complete = snapshot['complete'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'complete': complete,
      'archived': archived
    };
  }
}
