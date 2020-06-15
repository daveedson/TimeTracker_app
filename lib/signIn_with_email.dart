import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_original/widgets/FormButton.dart';

enum FormType { signIn, register }

class EmailSignInPage extends StatefulWidget {
  @override
  _EmailSignInPageState createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //default type of our form.
  FormType _formType = FormType.signIn;

  void _submit() {
    print(
        'email: ${_emailController.text}, password: ${_passwordController.text}');
  }

  //changes the state from Sign in to register
  void _toogleFormState() {
    setState(() {
      _formType =
          _formType == FormType.signIn ? FormType.register : FormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final primaryText = _formType == FormType.signIn ? 'Sign in' : "Register";
    final secondaryText = _formType == FormType.signIn
        ? ' Need an account ? Register'
        : "Already have an account ? Sign in.";
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Sign In"),
        elevation: 10.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
            child: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'Email', hintText: 'boy@email.com'),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 8.0),
                FormSubmitButton(text: primaryText, onPressed: _submit),
                FlatButton(
                  child: Text(secondaryText),
                  onPressed: _toogleFormState,
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
