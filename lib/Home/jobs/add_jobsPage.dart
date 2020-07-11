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

  String _name;
  int _ratePerHour;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _submit() {
    if (_validateAndSaveForm()) {
      print('Form Saved, name:$_name, ratePerHour: $_ratePerHour');
    }
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
