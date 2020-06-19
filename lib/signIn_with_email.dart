import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/widgets/FormButton.dart';
import 'package:time_tracker_app_original/widgets/platFormAlertDialog.dart';

enum FormType { signIn, register }

class EmailSignInPage extends StatefulWidget {
  EmailSignInPage({@required this.authController});
  final AuthController authController;
  @override
  _EmailSignInPageState createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  //default type of our form.
  FormType _formType = FormType.signIn;

  String get _email => _emailController.text.toString();

  String get _password => _passwordController.text.toString();

  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formType == FormType.signIn) {
        await widget.authController
            .signInWthEmailAndPassword(_email, _password);
      } else if (_formType == FormType.register) {
        await widget.authController
            .RegisterUserInWthEmailAndPassword(_email, _password);
      }
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      PlatFormAlertDialog(
              title: 'Sign In Failed',
              content: e.toString(),
              defaultActionText: 'Ok')
          .show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  final _formKey = GlobalKey<FormState>();
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Card(
                child: Container(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      enabled: _isLoading == false,
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'email cannot be empty';
                        }
                        if (email.length < 5) {
                          return 'email not valid';
                        }
                        if (email.contains('@')) {
                          return 'email is badly formatted';
                        } else {
                          return null;
                        }
                      },
                      onEditingComplete: _emailEditingComplete,
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'Email', hintText: 'boy@email.com'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      enabled: _isLoading == false,
                      validator: (password) {
                        if (password.isEmpty) {
                          return "password can't be empty";
                        }
                        if (password.length < 6) {
                          return "Password can't be less than 6";
                        } else {
                          return null;
                        }
                      },
                      onEditingComplete: _submit,
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 8.0),
                    FormSubmitButton(
                        text: primaryText,
                        onPressed: () {
                          if (_formKey.currentState.validate() && !_isLoading) {
                            _submit();
                          }
                        }),
                    FlatButton(
                      child: Text(secondaryText),
                      onPressed: !_isLoading ? _toogleFormState : null,
                    )
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
