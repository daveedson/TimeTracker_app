import 'package:flutter/material.dart';
import 'package:time_tracker_app_original/Home_page.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/services/auth.dart';
import 'package:time_tracker_app_original/sign_in_page.dart';

/*
this page holds the control flow for all the sign in and signOut....
 */

class LandingPage extends StatelessWidget {
  LandingPage({@required this.authController});

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: authController.onAuthStatChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            //this condition checks the state of the user,if the   user is signed in or not,so it can decide which page to show.
            if (user == null) {
              return SignInPage(
                authController: authController,
              );
            } else {
              return HomePage(
                authController: authController,
              );
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
