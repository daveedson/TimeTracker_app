import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/widgets/custom_raisedButton.dart';

import 'file:///C:/Users/ADMIN/AndroidStudioProjects/time_tracker_app_original/lib/signIn/signIn_with_email.dart';

class SignInPage extends StatefulWidget {
  //this method signs in the user anonymously  returning a future return type
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //loading state if the button is clicked
  bool _isloading = false;

  Future<void> _signInAnonymously(BuildContext context) async {
    setState(() {
      _isloading = true;
    });
    final authController = Provider.of<AuthController>(context, listen: false);
    try {
      await authController.signInAnonymously();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    setState(() {
      _isloading = true;
    });
    final authController = Provider.of<AuthController>(context, listen: false);

    try {
      await authController.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  Future<void> _logInWithFacebook(BuildContext context) async {
    setState(() {
      _isloading = true;
    });
    final authController = Provider.of<AuthController>(context, listen: false);
    try {
      await authController.loginInWithFacebook();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  void _signInWithEmail(BuildContext context) {
    setState(() {
      _isloading = true;
    });
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => EmailSignInPage(),
        ),
      );
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isloading = false;
      });
    }
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
            _buildCircularIndicator(context),
            SizedBox(height: 30.0),
            CustomRaisedButton(
              borderRadius: 5.0,
              child: Text(
                'Sign in with Google',
                style: TextStyle(color: Colors.black87, fontSize: 15.0),
              ),
              color: Colors.white,
              onPressed: () => _signInWithGoogle(context),
            ),
            SizedBox(
              height: 5.0,
            ),
            CustomRaisedButton(
              child: Text('Sign in with Facebook',
                  style: TextStyle(color: Colors.white, fontSize: 15.0)),
              color: Color(0xFF3344D92),
              borderRadius: 5.0,
              onPressed: () => _logInWithFacebook(context),
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
              onPressed: () => _signInAnonymously(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularIndicator(BuildContext context) {
    if (_isloading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Text(
        "Sign in",
        style: TextStyle(
            letterSpacing: 1.2, fontSize: 25.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    }
  }
}
