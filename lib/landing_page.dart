import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_original/Home_page.dart';
import 'package:time_tracker_app_original/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //instance creation of firebase user to authenticate, if user is signed in or not.
  FirebaseUser _user;

  //this method updates user state with an input of Firebase user, which takes them to the homeScreen page...
  void _updateUser(FirebaseUser user) {
    //print('user id : ${user.uid}');

    setState(() {
      _user =
          user; //this block simply changes the state of the user to the homepage
    });
  }

  @override
  Widget build(BuildContext context) {
    //this condition checks the state of the user,if the user to check if user is signed in or not,so it can decide which page to show.
    if (_user == null) {
      return SignInPage(
        onSignIn: _updateUser,
      );
    } else {
      return HomePage(); //temporal
    }
  }
}
