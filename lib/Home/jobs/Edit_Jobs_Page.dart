import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/Home/Job.dart';
import 'package:time_tracker_app_original/services/Database.dart';

class EditJobsPage extends StatefulWidget {
  final Database database;
  final Job job;

  const EditJobsPage({Key key, @required this.database, @required this.job})
      : super(key: key);
  static Future<void> show(BuildContext context, {Job job}) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditJobsPage(
                database: database,
                job: job,
              ),
          fullscreenDialog: true),
    );
  }

  @override
  _EditJobsPageState createState() => _EditJobsPageState();
}

class _EditJobsPageState extends State<EditJobsPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _ratePerHour;
  bool _isloading = false;

  //this method just helps to assign some initial variables if the job is not null
  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
    }
  }

  //this method validates the form
  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //this method submits/writes data to cloud firestore
  Future<void> _submit() async {
//    if (_validateAndSaveForm()) {
//      try {
//        //this gets the current list of jobs from fireStore
//        final jobs = await widget.database.readJobs().first;
//        final allJobNames = jobs.map((job) => job.name).toList();
//        if (widget.job != null) {
//          allJobNames.remove(widget.job.name);
//        }
//        if (allJobNames.contains(_name)) {
//          PlatFormAlertDialog(
//            title: 'Name already used',
//            defaultActionText: 'Ok',
//            content: 'Please enter another job',
//          ).show(context);
//        } else {
//          setState(() {
//            _isloading = true;
//          });
//          final job = Job(name: _name, ratePerHour: _ratePerHour);
//          await widget.database.setJob(job);
//          setState(() {
//            _isloading = false;
//          });
//          Navigator.of(context).pop();
//        }
//      } on PlatformException catch (e) {
//        PlatFormExceptionAlertDialog(title: 'Operation Failed', exception: e)
//            .show(context);
//      }
//      //TODO: Submit data to firestore dataBase
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job == null ? 'New Job' : 'Edit job'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _submit,
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: ModalProgressHUD(inAsyncCall: _isloading, child: _buildContents()),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildChildren(),
        ));
  }

  List<Widget> _buildChildren() {
    return [
      TextFormField(
        initialValue: _name,
        onSaved: (value) => _name = value,
        decoration: InputDecoration(labelText: 'Job name'),
        validator: (value) {
          if (value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
      ),
      TextFormField(
          initialValue: _ratePerHour != null ? _ratePerHour.toString() : null,
          onSaved: (newValue) => _ratePerHour = int.tryParse(newValue) ?? 0,
          validator: (value) {
            if (value.isEmpty) {
              return 'This field cannot be empty';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Rate per hour'),
          keyboardType: TextInputType.numberWithOptions(
            decimal: false,
            signed: false,
          )),
    ];
  }
}
