import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/validators.dart';

import '../PlatFormExceptionAlertDialog.dart';

enum EmailSignInFormType { register, signIn }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  //these two instances control the text that' s entering the textField.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //these two instances would control the focus of the cusor in our textfield..
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  //Default type of The form,this line makes this the default state of the form.
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  //These block assigns the the emailController and passwordController to a String Variable of Email & password
  String get _email => _emailController.text.toString();
  String get _password => _passwordController.text.toString();

  bool _submitted = false;
  bool _isLoading = false;

  //This is the method that's signs in with FireBase
  Future<void> _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final authController =
          Provider.of<AuthController>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await authController.signInWthEmailAndPassword(_email, _password);
      } else if (_formType == EmailSignInFormType.register) {
        await authController.RegisterUserInWthEmailAndPassword(
            _email, _password);
      }
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print(e.toString());
      PlatExceptionFormAlertDialog(title: 'Sign In Failed', exception: e)
          .show(context);
    } finally {
      setState(() {
        _submitted = false;
        _isLoading = false;
      });
    }
  }

  //this methods toogle's the state of the form
  void _toogleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;

      _submitted = false;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  //this method allows to move from the email textField.
  void _emailEditingDone() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  //widget Children
  List<Widget> _buildChildren(BuildContext context) {
    //this line changes the text of the button
    final raisedButtonText =
        _formType == EmailSignInFormType.signIn ? 'Sign In' : 'Register';
    final flatButtonText = _formType == EmailSignInFormType.signIn
        ? "Don't have an Account? Register"
        : "Already have an account Sign In";

    bool enableSubmitButton = widget.emailValidator.isValid(_email) &&
        widget.emailValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 6.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 6.0,
      ),
      RaisedButton(
        child: Text(
          raisedButtonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: enableSubmitButton ? _submit : null,
      ),
      FlatButton(
        onPressed: !_isLoading ? _toogleFormType : null,
        child: Text(
          flatButtonText,
        ),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.emailValidator.isValid(_password);
    return TextField(
      onEditingComplete: _submit,
      onChanged: (password) => _updateState(),
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      controller: _passwordController,
      decoration: InputDecoration(
        enabled: _isLoading == false,
        errorText: showErrorText ? "Password can't be empty" : null,
        labelText: 'Password',
      ),
      obscureText: true,
    );
  }

  TextField _buildEmailTextField() {
    bool emailValid =
        _submitted && !widget.emailValidator.isValid(_email) && !_isLoading;
    return TextField(
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingDone,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(
        enabled: _isLoading == false,
        errorText: emailValid ? "Email can't be empty" : null,
        labelText: 'Email',
        hintText: 'email@mail.com',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(context),
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }
}
