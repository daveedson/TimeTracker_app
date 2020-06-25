import 'package:flutter/material.dart';
import 'package:time_tracker_app_original/signIn/email_signIn_form.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Sign In',
        ),
        elevation: 10.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInForm(),
        ),
      ),
    );
  }
}
