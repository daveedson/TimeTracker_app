import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/Home/Job.dart';
import 'package:time_tracker_app_original/Home/jobs/Edit_jobsPage.dart';
import 'package:time_tracker_app_original/Home/jobs/job_list_tile.dart';
import 'package:time_tracker_app_original/Home/jobs/list_itemBuilder.dart';
import 'package:time_tracker_app_original/PlatFormExceptionAlertDialog.dart';
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
        title: 'Sign out ?',
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
        onPressed: () => EditJobsPage.show(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: _buildContent(context),
    );
  }

  Future<void> _delete(BuildContext context, job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatFormExceptionAlertDialog(
        title: 'Operation Failed',
        exception: e,
      ).show(context);
    }
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.readJobs(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) => _delete(context, job),
            key: Key('job-${job.id}'),
            background: Container(
              color: Colors.deepOrangeAccent,
            ),
            child: JobListTile(
              job: job,
              onTap: () => EditJobsPage.show(context, job: job),
            ),
          ),
        );
      },
    );
  }
}
