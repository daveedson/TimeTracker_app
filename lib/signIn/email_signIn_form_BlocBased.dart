import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/signIn/EmailSigninModel.dart';
import 'package:time_tracker_app_original/signIn/Email_signInForm_bloc.dart';

import '../PlatFormExceptionAlertDialog.dart';
import 'EmailSigninModel.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
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
  void _toogleFormType() {
    widget.emailBloc.ToogleFormType();
  }

  //this method allows to move from the email textField.
  void _emailEditingDone() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  //widget Children
  List<Widget> _buildChildren(EmailSignInModel model) {
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
          model.primaryButton,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: model.canSubmit ? _submit : null,
      ),
      FlatButton(
        onPressed: !model.isLoading ? _toogleFormType : null,
        child: Text(
          model.secondaryButton,
        ),
      ),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      onEditingComplete: _submit,
      onChanged: widget.emailBloc.updatePassword,
      focusNode: _passwordFocusNode,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      controller: _passwordController,
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        errorText: model.passwordErrorText,
        labelText: 'Password',
      ),
      obscureText: true,
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      onChanged: widget.emailBloc.updateEmail,
      onEditingComplete: _emailEditingDone,
      focusNode: _emailFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        errorText: model.emailErrorText,
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
