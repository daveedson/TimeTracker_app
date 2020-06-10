import 'package:flutter/material.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';

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
            onPressed: _signOut,
          )
        ],
      ),
    );
  }
}
