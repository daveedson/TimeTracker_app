import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/signIn/email_signIn_page.dart';
import 'package:time_tracker_app_original/signIn/sign_in_Bloc.dart';
import 'package:time_tracker_app_original/widgets/custom_raisedButton.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.bloc});

  final SignInBloc bloc;

  // final AuthController authController;
  /*
  this method is created to use the provider<SignInBloc> package as the parent of signInPage
    to allow seperating Ui code and business logic
    which also gives us a way of accessing the signInBloc class using the Provider Package.
   */
  static Widget create(BuildContext context) {
    final authController = Provider.of<AuthController>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInBloc>(
          create: (_) =>
              SignInBloc(authController: authController, isLoading: isLoading),
          child: Consumer<SignInBloc>(
            builder: (context, bloc, _) => SignInPage(bloc: bloc),
          ),
        ),
      ),
    );
  }

  //loading state if the button is clicked
//  bool _isloading = false;

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _logInWithFacebook(BuildContext context) async {
    try {
      await bloc.loginInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  //this method navigates to the email sign in page.
  void _signInWithEmail(BuildContext context) {
    // final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => EmailSignInPage(),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<ValueNotifier<bool>>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Time Tracker',
        ),
        elevation: 10.0,
      ),
      body: _buildContent(context, isLoading.value),
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildCircularIndicator(context, isLoading),
          SizedBox(height: 30.0),
          CustomRaisedButton(
            borderRadius: 5.0,
            child: Text(
              'Sign in with Google',
              style: TextStyle(color: Colors.black87, fontSize: 15.0),
            ),
            color: Colors.white,
            onPressed: () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 5.0,
          ),
          CustomRaisedButton(
            child: Text('Sign in with Facebook',
                style: TextStyle(color: Colors.white, fontSize: 15.0)),
            color: Color(0xFF3344D92),
            borderRadius: 5.0,
            onPressed: () => _logInWithFacebook(context),
          ),
          SizedBox(
            height: 5.0,
          ),
          CustomRaisedButton(
            child: Text(
              'Sign in with Email',
              style: TextStyle(color: Colors.black87, fontSize: 15.0),
            ),
            borderRadius: 5.0,
            color: Colors.yellowAccent[100],
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 5.0,
          ),
          CustomRaisedButton(
            child: Text(
              'Go anonymous',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            borderRadius: 5.0,
            color: Colors.teal,
            onPressed: () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator(BuildContext context, bool isloading) {
    if (isloading == true) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Text(
        "Sign in",
        style: TextStyle(
            letterSpacing: 1.2, fontSize: 25.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    }
  }
}
