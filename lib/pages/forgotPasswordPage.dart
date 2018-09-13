import 'package:flutter/material.dart';
import '../widgets/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String username;

  _sendPasswordRecoveryEmail() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Recovery'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendPasswordRecoveryEmail,
        child: Icon(Icons.restore),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            child: ListView(
              children: <Widget>[
                FlutterLogo(
                  style: FlutterLogoStyle.markOnly,
                  size: 100.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Please enter your email address to send you a reset password link.",
                  ),
                ),
                TextFormField(
                  onSaved: (val) { setState(() { username = val; }); },
                  validator: (val) => val == "" ? 'Please enter a valid email' : null,
                  autocorrect: false,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
