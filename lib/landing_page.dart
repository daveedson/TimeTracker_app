import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/services/Database.dart';
import 'package:time_tracker_app_original/services/FireStoreDatabase.dart';
import 'package:time_tracker_app_original/services/auth.dart';

import 'file:///C:/Users/ADMIN/AndroidStudioProjects/time_tracker_app_original/lib/signIn/sign_in_page.dart';

import 'Home/jobs/Jobs_page.dart';

/*
this page holds the control flow for all the sign in and signOut....
 */

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false); 

    return StreamBuilder<User>(
      stream: authController.onAuthStatChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          //this condition checks the state of the user,if the   user is signed in or not,so it can decide which page to show.
          if (user == null) {
            return SignInPage.create(context);
          } else {
            return Provider<Database>(
              create: (_) => FireStoreDatabase(uid: user.uid),
              child: JobsPage(),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
