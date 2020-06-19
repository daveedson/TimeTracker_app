import 'package:flutter/material.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/signIn_with_email.dart';
import 'package:time_tracker_app_original/widgets/custom_raisedButton.dart';

class SignInPage extends StatelessWidget {
  SignInPage({this.authController}); //Constructor for SignInPage Class..

  final AuthController authController;

  //this method signs in the user anonymously  returning a future return type
  Future<void> _signInAnonymously() async {
    try {
      await authController.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  //this method signs user in with Google..
  Future<void> _signInWithGoogle() async {
    try {
      await authController.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  //this method logs in with facebook
  Future<void> _logInWithFacebook() async {
    try {
      await authController.loginInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => EmailSignInPage(
                  authController: authController,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Time Tracker',
        ),
        elevation: 10.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign in",
              style: TextStyle(
                  letterSpacing: 1.2,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0),
            CustomRaisedButton(
              borderRadius: 5.0,
              child: Text(
                'Sign in with Google',
                style: TextStyle(color: Colors.black87, fontSize: 15.0),
              ),
              color: Colors.white,
              onPressed: _signInWithGoogle,
            ),
            SizedBox(
              height: 5.0,
            ),
            CustomRaisedButton(
              child: Text('Sign in with Facebook',
                  style: TextStyle(color: Colors.white, fontSize: 15.0)),
              color: Color(0xFF3344D92),
              borderRadius: 5.0,
              onPressed: _logInWithFacebook,
            ),
            SizedBox(
              height: 5.0,
            ),
            CustomRaisedButton(
              child: Text(
                'Sign in with Email',
                style: TextStyle(color: Colors.black87, fontSize: 15.0),
              ),
              borderRadius: 5.0,
              color: Colors.yellowAccent[100],
              onPressed: () => _signInWithEmail(context),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            CustomRaisedButton(
              child: Text(
                'Go anonymous',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              borderRadius: 5.0,
              color: Colors.teal,
              onPressed: _signInAnonymously,
            ),
          ],
        ),
      ),
    );
  }
}
