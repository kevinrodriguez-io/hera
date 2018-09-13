import 'package:firebase_database/firebase_database.dart';

class TodoItem {
  String key;
  String title = '';
  String description = '';
  bool complete = false;

  TodoItem(this.title, {this.description, this.complete});

  TodoItem.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value['title'],
        description = snapshot.value['description'],
        complete = snapshot.value['complete'];

  toJson() {
    return {'title': title, 'description': description, 'complete': complete};
  }
}
