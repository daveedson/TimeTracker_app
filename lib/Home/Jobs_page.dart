import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/Home/Job.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/services/Database.dart';
import 'package:time_tracker_app_original/widgets/platFormAlertDialog.dart';

class JobsPage extends StatelessWidget {
  //Method to SignOut User
  Future<void> _signOut(BuildContext context) async {
    final authController = Provider.of<AuthController>(context, listen: false);

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
        _signOut(context);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //this method adds data/records to the database..
  Future<void> _createJob(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await database.createJob(Job(name: "Blogging", ratePerHour: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Sign Out',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () => _conFirmSignOut(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createJob(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
