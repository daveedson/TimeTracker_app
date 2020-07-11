import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddJobPage extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddJobPage(), fullscreenDialog: true),
    );
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    //TODO: Validater and save form
    //TODO: Submit data to firestore dataBase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('New Job'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            onPressed: _submit,
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: _buildContents(),
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
        decoration: InputDecoration(labelText: 'Job name'),
      ),
      TextFormField(
          decoration: InputDecoration(labelText: 'Rate per hour'),
          keyboardType: TextInputType.numberWithOptions(
            decimal: false,
            signed: false,
          )),
    ];
  }
}
