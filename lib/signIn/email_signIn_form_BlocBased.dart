import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/signIn/EmailSigninModel.dart';
import 'package:time_tracker_app_original/signIn/Email_signInForm_bloc.dart';
import 'package:time_tracker_app_original/validators.dart';

import '../PlatFormExceptionAlertDialog.dart';
import 'EmailSigninModel.dart';

class EmailSignInFormBlocBased extends StatefulWidget
    with EmailAndPasswordValidators {
  EmailSignInFormBlocBased({@required this.emailBloc});
  final EmailSignInFormBloc emailBloc;

  static Widget create(BuildContext context) {
    final AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    return Provider<EmailSignInFormBloc>(
      create: (context) => EmailSignInFormBloc(authController: authController),
      child: Consumer<EmailSignInFormBloc>(
        builder: (context, bloc, _) =>
            EmailSignInFormBlocBased(emailBloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  //these two instances control the text that' s entering the textField.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //these two instances would control the focus of the cusor in our textfield..
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  //Default type of The form,this line makes this the default state of the form.
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //This is the method that's signs in with FireBase
  Future<void> _submit() async {
    try {
      await widget.emailBloc.submit();
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print(e.toString());
      PlatExceptionFormAlertDialog(title: 'Sign In Failed', exception: e)
          .show(context);
    }
  }

  //this methods toogle's the state of the form
  void _toogleFormType(EmailSignInModel model) {
    widget.emailBloc.updateWith(
      email: '',
      password: '',
      formType: model.formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,
      submitted: false,
      isLoading: false,
    );
  }

  //this method allows to move from the email textField.
  void _emailEditingDone() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  //widget Children
  List<Widget> _buildChildren(EmailSignInModel model) {
    //this line changes the text of the button
    final raisedButtonText =
        model.formType == EmailSignInFormType.signIn ? 'Sign In' : 'Register';
    final flatButtonText = _formType == EmailSignInFormType.signIn
        ? "Don't have an Account? Register"
        : "Already have an account Sign In";

    bool enableSubmitButton = widget.emailValidator.isValid(model.email) &&
        widget.emailValidator.isValid(model.password) &&
        !model.isLoading;

    return [
      _buildEmailTextField(model),
      SizedBox(
        height: 6.0,
      ),
      _buildPasswordTextField(model),
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
        onPressed: !model.isLoading ? () => _toogleFormType(model) : null,
        child: Text(
          flatButtonText,
        ),
      ),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    bool showErrorText =
        model.submitted && !widget.emailValidator.isValid(model.password);
    return TextField(
      onEditingComplete: _submit,
      onChanged: (password) => widget.emailBloc.updateWith(password: password),
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      controller: _passwordController,
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        errorText: showErrorText ? "Password can't be empty" : null,
        labelText: 'Password',
      ),
      obscureText: true,
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    bool emailValid = model.submitted &&
        !widget.emailValidator.isValid(model.email) &&
        !model.isLoading;
    return TextField(
      onChanged: (email) => widget.emailBloc.updateWith(email: email),
      onEditingComplete: _emailEditingDone,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        errorText: emailValid ? "Email can't be empty" : null,
        labelText: 'Email',
        hintText: 'email@mail.com',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.emailBloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
