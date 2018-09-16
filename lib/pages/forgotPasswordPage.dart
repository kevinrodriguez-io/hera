import 'package:flutter/material.dart';
import '../widgets/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username;
  bool isSendingRecoveryEmail = false;

  _sendPasswordRecoveryEmail() {
    if (isSendingRecoveryEmail) return;
    setState(() {
      isSendingRecoveryEmail = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Sending Recovery Email'),
    ));

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        isSendingRecoveryEmail = false;
      });
      return;
    }

    form.save();

    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: username);
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('Password reset email sent! Please check your email address.'),
      ));
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ));
    } finally {
      setState(() { isSendingRecoveryEmail = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            key: _formKey,
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
                  onSaved: (val) {
                    setState(() {
                      username = val;
                    });
                  },
                  validator: (val) =>
                      val == "" ? 'Please enter a valid email' : null,
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
