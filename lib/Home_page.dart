import 'package:flutter/material.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/widgets/platFormAlertDialog.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.authController});

  final AuthController authController;

  //Method to SignOut User
  Future<void> _signOut() async {
    try {
      await authController.signOut();
    } catch (e) {
      print('something went wrong: $e');
    }
  }

  Future<void> _conFirmSignOut(BuildContext context) async {
    try {
      final grantSignOut = await PlatFormAlertDialog(
        title: 'Logout ?',
        content: 'Are you sure you want to log out?',
        cancelActionText: 'Cancel',
        defaultActionText: 'LogOut',
      ).show(context);
      if (grantSignOut == true) {
        _signOut();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'SignOut',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () => _conFirmSignOut(context),
          )
        ],
      ),
    );
  }
}
