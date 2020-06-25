import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';
import 'package:time_tracker_app_original/signIn/sign_In_with_email_ModelClass.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.authController});
  final AuthController authController;
  final StreamController<EmailSignInModelClass> emailStreamController =
      new StreamController<EmailSignInModelClass>();

  Stream<EmailSignInModelClass> get modelStream => emailStreamController.stream;

  EmailSignInModelClass _emailModel = new EmailSignInModelClass();

  void dispose() {
    emailStreamController.close();
  }

  Future<void> submit() async {
    updatewith(isLoading: true);
    try {
      if (_emailModel.formType == FormType.signIn) {
        await authController.signInWthEmailAndPassword(
            _emailModel.email, _emailModel.password);
      } else if (_emailModel.formType == FormType.register) {
        await authController.RegisterUserInWthEmailAndPassword(
            _emailModel.email, _emailModel.password);
      }
    } catch (e) {
      rethrow;
    } finally {
      updatewith(isLoading: false);
    }
  }

  void updatewith({
    String email,
    String password,
    FormType formType,
    bool isLoading,
  }) {
    _emailModel = _emailModel.copyWith(
      email: email,
      password: password,
      isLoading: isLoading,
      formType: formType,
    );
    emailStreamController.add(_emailModel);
  }
}
