import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/signIn/EmailSigninModel.dart';

class EmailSignInFormBloc {
  EmailSignInFormBloc({@required this.authController});
  final AuthController authController;
  StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = new EmailSignInModel();
  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await authController.signInWthEmailAndPassword(
            _model.email, _model.password);
      } else if (_model.formType == EmailSignInFormType.register) {
        await authController.RegisterUserInWthEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false, submitted: false);
      rethrow;
    }
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);

  void ToogleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      submitted: false,
      isLoading: false,
    );
  }

  //this method adds values to the stream..
  void updateWith(
      {String email,
      String password,
      EmailSignInFormType formType,
      bool submitted,
      bool isLoading}) {
    //this method  updates model
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      submitted: submitted,
      isLoading: isLoading,
    );

    //add a new value to our stream
    _modelController.add(_model);
  }
}
