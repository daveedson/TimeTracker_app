import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/signIn/EmailSigninModel.dart';

import '../PlatFormExceptionAlertDialog.dart';
import 'EmailSigninChangeModel.dart';
import 'EmailSigninModel.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  EmailSignInFormChangeNotifier({@required this.emailModel});
  final EmailSignInChangeModel emailModel;

  static Widget create(BuildContext context) {
    final AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (context) =>
          EmailSignInChangeModel(authController: authController),
      child: Consumer<EmailSignInChangeModel>(
        builder: (context, emailModel, _) =>
            EmailSignInFormChangeNotifier(emailModel: emailModel),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState
    extends State<EmailSignInFormChangeNotifier> {
  //these two instances control the text that' s entering the textField.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //these two instances would control the focus of the cusor in our textfield..
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.emailModel;
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
      await widget.emailModel.submit();
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print(e.toString());
      PlatFormExceptionAlertDialog(title: 'Sign In Failed', exception: e)
          .show(context);
    }
  }

  //this methods toogle's the state of the form
  void _toogleFormType() {
    widget.emailModel.ToogleFormType();
  }

  //this method allows to move from the email textField.
  void _emailEditingDone() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  //widget Children
  List<Widget> _buildChildren() {
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

  TextField _buildPasswordTextField() {
    return TextField(
      onEditingComplete: _submit,
      onChanged: model.updatePassword,
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

  TextField _buildEmailTextField() {
    return TextField(
      onChanged: model.updateEmail,
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
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
