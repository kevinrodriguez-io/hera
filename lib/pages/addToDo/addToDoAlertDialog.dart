import 'package:flutter/material.dart';
import 'package:hera/models/TodoItem.dart';

class AddTodoAlertDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTodoAlertDialogState();
}

class _AddTodoAlertDialogState extends State<AddTodoAlertDialog> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _description;

  _saveTodo(BuildContext context) {
    final formState = _formKey.currentState;
    if (!formState.validate()) return;
    formState.save();
    Navigator.of(context)
        .pop(TodoItem(_title, description: _description, complete: false));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add To-Do'),
      contentPadding: EdgeInsets.all(20.0),
      content: Container(
        child: Form(
          key: _formKey,
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _title = val;
                  });
                },
                decoration: InputDecoration(labelText: 'Title'),
                validator: (val) => val == "" ? 'Please enter a title' : null,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _description = val;
                  });
                },
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(null);
          },
          textColor: Colors.blueGrey,
          child: Text('Cancel'),
        ),
        RaisedButton(
          onPressed: () {
            _saveTodo(context);
          },
          child: Text('Add'),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
        )
      ],
    );
  }
}
